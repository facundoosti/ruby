class App < Sinatra::Base
  set :root, Dir.pwd
  set :host, 'https//:localhost:9292'

  # ActiveRecord
  environment = ENV['RACK_ENV'] || 'development'
  hash = YAML.load(File.new(root + '/config/database.yml'))[environment]
  ActiveRecord::Base.establish_connection(hash)

  # FIXME: porque hay que poner esto ??
  ActiveRecord::Base.connection
  ActiveRecord::Base.include_root_in_json = false
  
  helpers do
    def a_time date, *hr 
      fecha = date.scan(/\w+/)
      year  = fecha[0].to_i
      month =fecha[1].to_i
      day   =fecha[2].to_i
      if hr.nil?
        h=0
        m=0
        s=0
      else
        h=fecha[3].to_i
        m=fecha[4].to_i
        s=fecha[5].to_i
      end
      Time.utc(year,month,day,h,m,s)
    end
    
    def links operando, str, *method
      a = [{rel: operando, uri:settings.host + str}]
      if !(method.empty?)
        a.first[:method]=method.first
      end
      a     
    end

  end

  configure :development do
    register Sinatra::Reloader
    also_reload 'app/models/*.rb'
    also_reload 'app/controllers/*.rb'
  end
end
