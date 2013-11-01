class App < Sinatra::Base
  get '/' do
    raise 'pepe'
    erb :index
  end
end