class App < Sinatra::Base
  set :root, Dir.pwd

  # ActiveRecord
  environment = ENV['RACK_ENV'] || 'development'
  hash = YAML.load(File.new(root + '/config/database.yml'))[environment]
  ActiveRecord::Base.establish_connection(hash)

  # FIXME: porque hay que poner esto ??
  ActiveRecord::Base.connection
  ActiveRecord::Base.include_root_in_json = true

  helpers do
   
  end

  configure :development do
    register Sinatra::Reloader
    also_reload 'app/models/*.rb'
    also_reload 'app/controllers/*.rb'
  end
end
