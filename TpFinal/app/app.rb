class App < Sinatra::Base
  set :root, Dir.pwd

  # ActiveRecord
  environment = ENV['RACK_ENV'] || 'development'
  hash = YAML.load(File.new(root + '/config/database.yml'))[environment]
  ActiveRecord::Base.establish_connection(hash)

  helpers do
  end

  configure :development do
    register Sinatra::Reloader
  end 

  get '/' do
    "prpre"
  end
end
