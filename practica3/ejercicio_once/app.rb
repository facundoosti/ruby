require 'bundler'
Bundler.require

before '/:nro' do
	@titulo      = "Ruta:#{params[:nro]}"
	@now		 = "#{params[:nro]}"
    request.path_info = "/#{params[:nro]}"
end

get '/uno' do
	@action_name = "uno"
	erb :index 
end

get '/dos' do
	@action_name = "dos"
	erb :index 
end

get '/tres' do
	@action_name = "tres"
	erb :index 
end
