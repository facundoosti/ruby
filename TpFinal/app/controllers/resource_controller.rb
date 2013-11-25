#require 'json'

class App < Sinatra::Base
  
  #Listar todos los recursos
  get '/resources' do
    Resource.all.to_json(only: [:name, :description],methods: :links)
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
    
    (date.empty?) ? date = (Time.now + 1.day).to_s : date
    (limit.empty?) ? limit = "30" : limit
    (status.empty?) ? status = "approved" : status

  #  StatusBooking.joins(:bookings).to_json
    #Resource.find(params[:id_resource]).list_bookings(limit, status, date).to_json

    bookings = Request.bookings_with(@resource_id,@date,@limit,@status)
  end 
  
  #Disponibilidad de un recurso a partir de una fecha
  get '/resources/:id_resource/availability' do
    limit = params[:limit]
    (limit.empty?) ? limit = "10" : limit.
  #  reserve = Resource.find_by(resource_id: params[:id_resource]).availabilities.select( { | self | self.status.name == "approved" }).take(limit)
   # reserve.order(:start)
    Struct.new("Availability", :from, :to) 
  end 
  
  #reservar recurso
  post '/resources/:id_resource/bookings' do
    begin
      from ||= Time.iso8601(params[:from])
      to ||= Time.iso8601(params[:to])
    rescue ArgumentError
      halt 400
    end
  end 
  
  #cancelar reserva
  delete '/resources/:id_resource/bookings/:id_booking' do
    reserve = Booking.find_by(resource_id: params[:id_resource])
    halt 404 unless reserve 
    reserve.destroy
  end 

  #autorizar reserva
  put '/resources/:id_resource/bookings/:id_booking' do
    ""
  end

  #mostrar reserva
  get '/resources/:id_resource/bookings/:id_booking' do
    Booking.find_by(resource_id: params[:id_resource], booking_id:params[:id_booking]).to_json
  end
end