require 'bundler'
Bundler.require

get '/saludo' do
	"hello world!"
end

get '/saludo/:name' do
	"hello #{params[:name]}"
end	