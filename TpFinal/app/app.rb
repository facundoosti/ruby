class App < Sinatra::Base
  set :root, Dir.pwd
  set :host, 'http://localhost:9292'

  # ActiveRecord
  environment = ENV['RACK_ENV'] || 'development'
  hash = YAML.load(File.new(root + '/config/database.yml'))[environment]
  ActiveRecord::Base.establish_connection(hash)
  ActiveRecord::Base.connection
  ActiveRecord::Base.include_root_in_json = false

  before { content_type :json}  

  after { ActiveRecord::Base.connection.close }
  
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
