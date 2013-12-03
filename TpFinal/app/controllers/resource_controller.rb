class App < Sinatra::Base
  
  #Listar todos los recursos
  get '/resources' do
    resources = Resource.all.to_json(only: [:name, :description],methods: :links)
    {resources: JSON.parse(resources)}.to_json
  end

  #ver un recurso
  get '/resources/:id_resource' do 
    begin
      Resource.find(params[:id_resource]).to_json(only: [:name, :description],methods: :links)
    rescue ActiveRecord::RecordNotFound => e
      halt 404
    end
  end  

  #Listar reservas de un recurso
  get '/resources/:id_resource/bookings' do

    date   = params[:date]
    limit  = params[:limit]
    status = params[:status]
    begin
    (date.empty?) ? date = (Time.now + 1.day).to_s : date = a_time(params[:date]).to_s
    (limit.empty?) ? limit = '30' : limit
    (status.empty?) ? status = 'approved' : status

      begin
        Resource.find(params[:id_resource]).bookings.where('start >= ?',date).select{|b| b.whith_status status }.take(limit.to_i).to_json
      rescue ActiveRecord::RecordNotFound => e
        halt 404
      end
    rescue NoMethodError
      redirect '/resources', 303
    end
  end 
  
  #Disponibilidad de un recurso a partir de una fecha
  get '/resources/:id_resource/availability' do

    date   = params[:date] 
    limit = params[:limit]

    (date.empty?) ? date = (Time.now + 1.day).to_s : date = a_time(params[:date]).iso8601
    (limit.empty?) ? limit = 3 : limit

    begin
      bookings = Resource.find(params[:id_resource]).bookings.where('start >= ?',date.to_s).select{|b| b.whith_status 'approved' }.take(limit)
    
      hash= {availability: []}
      from = date    
      bookings.each do |book|
        to = book.end
        hash[:availability] << {from: from,to: to}
        from = book.start
      end
      hash.to_json
    rescue ActiveRecord::RecordNotFound => e
        halt 404
    end
  end 
  
  #reservar recurso
  #curl -v -d "form='2013-11-12-00-00-00'&to:'2013-11-12-03-00-00'" http://localhost:9292/resources/1/bookings

  post '/resources/:id_resource/bookings' do 
    from = a_time(params[:from])
    to   = a_time(params[:to])
    resource = Resource.find_by(id:params[:id_resource])
    ok = Booking.all.select{|b| (from.between(b.start,b.end))|(to.between(b.start,b.end))}
    halt 409 unless ok.empty?
    Booking.create(start: from, end: to , resource: resource)
  end 
  
  #cancelar reserva
  delete '/resources/:id_resource/bookings/:id_booking' do
    book = Booking.find_by(resource_id: params[:id_resource])
    halt 404 unless book 
    book.destroy
  end 

  #autorizar reserva
  put '/resources/:id_resource/bookings/:id_booking' do
      bookings = Booking.all.select{|b| b.whith_status 'approved' }
      book = Booking.find_by(id: params[:id_booking])
      halt 404  unless book
      ok = bookings.select{|b| (book.start.between(b.start,b.end))|(book.end.between(b.start,b.end))}
      halt 409 unless ok.empty?
      book.update(status: :approved)
  end

  #mostrar reserva
  get '/resources/:id_resource/bookings/:id_booking' do
    book = Booking.find_by(booking_id:params[:id_booking]).to_json
    halt 404 unless book 
  end
end