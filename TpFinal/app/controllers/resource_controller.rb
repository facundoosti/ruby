class App < Sinatra::Base
  # Listar todos los recursos
  get '/resources' do
    resources = Resource.all.to_json(only: [:name, :description],methods: :links)
    {resources: JSON.parse(resources), links: links('self',request.path) }.to_json
  end

  # ver un recurso
  get '/resources/:id_resource' do 
    begin
    resource = JSON.parse(Resource.find(params[:id_resource]).to_json(root:true,only: [:name, :description],methods: :links ))
    resource["resource"]["links"] << links('bookings',"# {request.path}/bookings").first
    resource.to_json
    rescue ActiveRecord::RecordNotFound => e
      halt 404
    end
  end  

  # Listar reservas de un recurso
  get '/resources/:id_resource/bookings' do
    date   = params[:date]
    limit  = params[:limit]
    status = params[:status]
    begin 
    (date.empty?) ? date = (Time.now + 1.day).gmtime.iso8601 : date = a_time(params[:date]).to_s
    (limit.empty?) ? limit = '30' : limit
    (status.empty?) ? status = 'approved' : status
      begin
        b = Resource.find(params[:id_resource]).bookings.where('start >= ?',date).select{|b| b.whith_status status }.take(limit.to_i).to_json(only: [:start,:end,:status,:user],methods: :links)
        {bookings: JSON.parse(b), links:[{rel:'self', uri: request.url }]}.to_json # FIX
      rescue ActiveRecord::RecordNotFound => e
        halt 404
      rescue ArgumentError
        redirect '/resources', 303
      end
    rescue NoMethodError
      redirect '/resources', 303
    end
  end 
  
  # Disponibilidad de un recurso a partir de una fecha
  get '/resources/:id_resource/availability' do

    date   = params[:date] 
    limit = params[:limit]

    (date.empty?) ? date = (Time.now + 1.day).gmtime.iso8601 : date = a_time(params[:date]).iso8601
    (limit.empty?) ? limit = '3' : limit
    begin
      bookings = Resource.find(params[:id_resource]).bookings.order(:start).where('start >= ?',date).select{|b| b.whith_status 'approved' }.take(limit.to_i)
    
      hash= {availability: [], links:[]}
      (bookings.first.start < date) ? date =  bookings.first.end : date
      from = date
      bookings.each do |book|
        to = book.start
        link = links('book', "/resources/# {book.resource.id}/bookings", "POST")
        link << links('resource', "/resources/# {book.resource.id}").first
        hash[:availability] << {from: from,to: to, links: link}
        from = book.end
      end
      hash[:links] << {rel:'self', uri:request.url}
      hash.to_json
    rescue ActiveRecord::RecordNotFound => e
        halt 404
    end
  end 
  
  # reservar recurso
  # curl -v -d "from='2013-12-03T20:39:01Z'&to='2013-11-14T14:00:00Z'" http://localhost:9292/resources/1/bookings
  post '/resources/:id_resource/bookings' do
    begin 
      resource = Resource.find(params[:id_resource])
      halt 409 unless resource.available_to_book?(params[:from], params[:to])
      resource.bookings.create start: params[:from], end: params[:to]
      status 201
    rescue ActiveRecord::RecordNotFound => e
      halt 404
    end
  end 
  
  # cancelar reserva
  # curl -v -X DELETE localhost:9292/resources/1/bookings/3
  delete '/resources/:id_resource/bookings/:id_booking' do
    begin
      book = Resource.find(params[:id_resource]).bookings.find(params[:id_booking])
      book.destroy
    rescue ActiveRecord::RecordNotFound => e 
      halt 404
    end
  end

  # autorizar reserva
  # curl -v -X PUT localhost:9292/resources/1/bookings/2
  put '/resources/:id_resource/bookings/:id_booking' do
    begin
      resource = Resource.find(params[:id_resource])
      booking = resource.bookings.find(params[:id_booking])
      booking.update status: :approved
      resource.cancel_pending_bookings
      booking.to_json(only: [:start, :end, :status], methods: :links)
    rescue ActiveRecord::RecordNotFound => e 
      halt 404
    end
  end

  # mostrar reserva
  get '/resources/:id_resource/bookings/:id_booking' do
    begin
      Resource.find(params[:id_resource]).bookings.find(params[:id_booking]).to_json(only:[:start,:end,:status],methods: :links)
    rescue ActiveRecord::RecordNotFound => e # FIX Formato de Json
      halt 404
    end  
  end
end