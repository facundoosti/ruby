class App < Sinatra::Base

	enable :sessions

	configure :development do #permite Configurar el entorno en etapa de desarrollo
    	register Sinatra::Reloader #Recarga los archivos para no realizar la carga del servidor
  	end 

  	set(:autorizar) {
		condition do
			unless session[:username].nil?
				redirect '/',303
			end
		end
	}

	get '/' do
		redirect to('/login')
	end

	get '/login' do
		erb :login
	end

	post('/login') do
	    if params[:name] == 'Facu' 
	      "username = " << session[:username].inspect	
	      session[:username] = params[:name]
	      redirect '/questions/1'
	    else		
	      redirect '/login'
	    end
	end
	
	get '/questions/:nro' do
	    "Hello World"
	end
	
	
end


#get '/calificacions', autorizar: :session do
#	erb :index 
