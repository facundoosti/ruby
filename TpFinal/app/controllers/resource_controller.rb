require 'json'

class App < Sinatra::Base
  
  #Listar todos los recursos
  get '/resources' do
    Resource.all.to_json 
  end

  #ver un recurso
  #FIXME: debo verificar q id_resource sea entero y que id_resource este dentro del rango
  get '/resource/:id_resource' do 
    Resource.find(params[:id_resource]).to_json
  end  
  

  #Listar reservas de un recurso
  get '/resources/:id_resource/bookings' do
    #resource_id = params[:id_resource]

    (params[:date].empty?) ? params[:date] = (Time.now + (60*60*24)).to_s : params[:date]

    (params[:limit].empty?) ? params[:limit] = "30" : params[:limit]

    (params[:status].empty?) ? params[:status] = "approved" : params[:status]

    params[:status]+" "+params[:limit]+" "+params[:date]
    #bookings = Request.bookings_with(@resource_id,@date,@limit,@status)
  end 
  
  #Disponibilidad de un recurso a partir de una fecha
  get '/resources/:id_resource/availability?date=YYYY-MM-DD&limit=30' do
    ""
  end 
  
  #reservar recurso
  post '/resources/:id_resource/bookings' do
    ""
  end 
  
  #cancelar reserva
  delete '/resources/:id_resource/bookings/:id_booking' do
    ""
  end 

  #autorizar reserva
  put '/resources/:id_resource/bookings/:id_booking' do
    ""
  end

  #mostrar reserva
  get '/resources/:id_resource/bookings/:id_booking' do
    Request.find_by resource_id: params[:id_resource], booking_id:params[:id_booking]
  end

 

end