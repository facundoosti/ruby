require 'json'
class App < Sinatra::Base
  
  #Listar todos los recursos
  get '/resources' do
    Resource.all.to_json 
  end

  #ver un recurso
  get '/resource/:id_resource' do
    Resource.find(params[:id_resource]).to_json
  end  

  #Listar reservas de un recurso
  get '/resources/:id_resource/bookings?date='"YYYY-MM-DD&limit=30&status=all"'' do
    ""
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
    ""
  end

 

end