require 'bundler'
Bundler.require

helpers do
  def now
   	"<%= 'zaraza' %>"
  end
end
before '/:nro' do
	@action_name = "#{params[:nro]}"
    request.path_info = "/#{params[:nro]}"
end

get '/uno' do
	erb :index_dos 
end

get '/dos' do
	erb :index_dos
end

get '/tres' do
	erb :index_dos
end
