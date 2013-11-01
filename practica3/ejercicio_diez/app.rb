require 'bundler'
Bundler.require

get '/saludo' do
	@estilo = "./estilo_uno.css"
	@titulo = "Saludos generales!"
	@texto = "hello world!"
	erb :index 
end

get '/saludo/:nombre' do
	@estilo = "./estilo_dos.css"
	@titulo = "Saludos para #{params[:nombre]}"
	@texto = "hello #{params[:nombre]}"
	erb :index 
end	
