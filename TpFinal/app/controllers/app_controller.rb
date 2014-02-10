class App < Sinatra::Base
  # Listar todos los recursos
  get '/resources' do
    resources = Resource.all.to_json(only: [:name, :description], methods: :links)
    resources = JSON.parse(resources)
    resources.each { |r| r['links'] = [links('self', "/resources/#{r['links']}")] }
    { resources: resources, links: [links('self', request.path)] }.to_json
  end

  # ver un recurso
  get '/resources/:id_resource' do
    begin
      resource = JSON.parse(Resource.find(params[:id_resource]).to_json(root: true, only: [:name, :description], methods: :links))
      resource['resource']['links'] = [links('self', request.path)]
      resource['resource']['links'] << links('bookings', "#{request.path}/bookings")
      resource.to_json
    rescue ActiveRecord::RecordNotFound => e
      halt 404
    end
  end
  get '/' do
    raise (request.scheme + "://" +request.host + ":" + request.port.to_s)
  end  

    # Listar reservas de un recurso
  get '/resources/:id_resource/bookings' do
  
    params[:date]   ||= '' 
    params[:limit]  ||= '' 
    params[:status] ||= '' 

    # validar date con:blanco,zaraza y tiene que cumplir el formato 'YYYY-MM-DD'
    (params[:date].empty? | !(valid_date? params[:date])) ? date = Date.parse((Time.now + 1.day).strftime('%F')) : date = Date.parse(params[:date])

    # valida limit
    params[:limit] = '30' if (params[:limit].to_i == 0) | (params[:limit].to_i > 365)
    (params[:limit].empty?) ? limit = 30 : limit = params[:limit].to_i
    
    date_path= "?date=#{date}&limit=#{limit}"
    
    limit = date + (limit.day)
    # valido status
    status_validate = status_validator params[:status]

    if params[:status].empty? | !status_validate
      status = 'approved'
    elsif status_validate
      status = params[:status]
    end
    date_path = date_path +"&status=#{status}"

    begin
      bookings = JSON.parse(Resource.find(params[:id_resource]).bookings_since_to(date.iso8601, limit.iso8601).select { |b| b.whith_status status }.to_json(only: [:start, :end, :status, :user], methods: :links))
      
      bookings = links_for_bookings(bookings)
      { bookings: bookings , links: [links('self', request.path+date_path)] }.to_json
    rescue ActiveRecord::RecordNotFound => e
      halt 404
    rescue ArgumentError
      redirect '/resources', 303
    end 
  end

  get '/' do
    params[:name] = '' if params[:name].nil?
    raise params[:name].empty?.inspect
  end  
  # Disponibilidad de un recurso a partir de una fecha

  get '/resources/:id_resource/availability' do

    params[:date]  ||= '' 
    params[:limit] ||= '' 

    # FIX: fecha me tira 3 horas desp de la hora que tendria valid_date = 'YYYY-MM-DDTHH:MM:SSZ'
    (params[:date].empty? | !(valid_date? params[:date])) ? date = Date.parse((Time.now + 1.day).strftime('%F')) : date = Date.parse(params[:date])

    params[:limit] = '3' if (params[:limit].to_i == 0) | (params[:limit].to_i > 365)
    (params[:limit].empty?) ? limit = 3 : limit = params[:limit].to_i

    date_path= "?date=#{date}&limit=#{limit}"
    limit = date + (limit.day)

    begin
      bookings = Resource.find(params[:id_resource]).bookings_approved_since(date.iso8601, limit.iso8601)
    rescue ActiveRecord::RecordNotFound => e
        halt 404
    end
    
    hash = { availability: [], links: [] }

    unless bookings.first.nil?
      if bookings.first.start < date
        date = bookings.first.end
        bookings.delete_at(bookings.index(bookings.first))
      end

      from = date

      bookings.each do |book|
        to = book.start
        link = [links('book', "/resources/#{book.resource.id}/bookings", 'POST')]
        link << links('resource', "/resources/#{book.resource.id}")
        hash[:availability] << { from: from, to: to, links: link }
        from = book.end
      end

      if bookings.last.end > limit
        to = bookings.last.start
      end

      to = limit
      link = [links('book', "/resources/#{params[:id_resource]}/bookings", 'POST')]
      link << links('resource', "/resources/#{params[:id_resource]}")
      hash[:availability] << { from: from, to: to, links: link }

    end  

    hash[:links] << [links('self', request.path+date_path)]
    hash.to_json
  end

  # reservar recurso
  # curl -v -d 'from='2013-12-03T20:39:01Z'&to='2013-11-14T14:00:00Z'' http://localhost:9292/resources/1/bookings
  post '/resources/:id_resource/bookings' do
    begin
      resource = Resource.find(params[:id_resource])
    rescue ActiveRecord::RecordNotFound => e
      halt 404
    end
    halt 409 unless resource.available_to_book?(params[:from], params[:to])
    resource.bookings.create start: params[:from], end: params[:to]
    status 201
  end

  # cancelar reserva
  # curl -v -X DELETE localhost:9292/resources/1/bookings/3
  delete '/resources/:id_resource/bookings/:id_booking' do
    begin
      book = Resource.find(params[:id_resource]).bookings.find(params[:id_booking])
    rescue ActiveRecord::RecordNotFound => e
      halt 404
    end
    book.destroy
  end

  # autorizar reserva
  # curl -v -d '' -X PUT localhost:9292/resources/1/bookings/2
  put '/resources/:id_resource/bookings/:id_booking' do
    begin
      resource = Resource.find(params[:id_resource])
      booking = resource.bookings.find(params[:id_booking])
    rescue ActiveRecord::RecordNotFound => e
      halt 404
    end
    booking.update status: :approved
    resource.cancel_pending_bookings
    book = JSON.parse(booking.to_json(only: [:start, :end, :status], methods: :links))
    book['links'] = links_to_book(book['links']['id'].to_s, book['links']['resource_id'].to_s)
    book.replace(from: book['start'], to: book['end'], status: book['status'], links: book['links'])
    { book: book }.to_json
  end

  # mostrar reserva
  # Fix:formato del json
  get '/resources/:id_resource/bookings/:id_booking' do
    begin
      book = JSON.parse(Resource.find(params[:id_resource]).bookings.find(params[:id_booking]).to_json(only: [:start, :end, :status], methods: :links))
    rescue ActiveRecord::RecordNotFound => e
      halt 404
    end
    book['links'] = links_to_book(book['links']['id'].to_s, book['links']['resource_id'].to_s)
    book.replace(from: book['start'], to: book['end'], status: book['status'], links: book['links']).to_json
  end
end
