require 'bundler'
Bundler.require

get '/codigo/:code' do
	Integer(params[:code])
end	