class App < Sinatra::Base

  helpers do
    def form method, action, &block
      "<form method='post' action='#{action[:action]}'>#{yield(block)}</form>"
    end
    
    def input type, name
      "<input type='#{type}' name='_method' value='#{name}'>"
    end
  end

  configure do
    set :views, 'app/views'
  end

  configure :development do
    register Sinatra::Reloader
  end 
end
