require 'bundler'
Bundler.require

enable :sessions

set(:autorizar) {
	condition do
		unless session[:username].nil?
			redirect '/',303
		end
	end
}

get '/' do
	erb :index 
end

get '/login' do
	erb :login
end

post('/login') do
    if params[:name] == 'Facu' 
      session[:username] = params[:name]
    else
      redirect '/login'
    end
end


#get '/question/:nro' , autorizar: :session do
#	erb :index 
#end

#get '/calificacions', autorizar: :session do
#	erb :index 
