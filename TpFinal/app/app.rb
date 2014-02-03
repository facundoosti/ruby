class App < Sinatra::Base
  set :root, Dir.pwd
  set :host, 'https//localhost:9292'

  # ActiveRecord
  environment = ENV['RACK_ENV'] || 'development'
  hash = YAML.load(File.new(root + '/config/database.yml'))[environment]
  ActiveRecord::Base.establish_connection(hash)
  ActiveRecord::Base.connection
  ActiveRecord::Base.include_root_in_json = false

  after do
    ActiveRecord::Base.connection.close
  end
  
  # Helpers
  helpers do
      require_relative './helpers.rb'  #Nose porq no lo carga en el init.rb 
      include Helpers    
  end  

  configure :development do
    register Sinatra::Reloader
    also_reload 'app/models/*.rb'
    also_reload 'app/controllers/*.rb'
  end
end
