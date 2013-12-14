class App < Sinatra::Base
  set :root, Dir.pwd
  set :host, 'https//:localhost:9292'

  # ActiveRecord
  environment = ENV['RACK_ENV'] || 'development'
  hash = YAML.load(File.new(root + '/config/database.yml'))[environment]
  ActiveRecord::Base.establish_connection(hash)
  ActiveRecord::Base.connection
  ActiveRecord::Base.include_root_in_json = false
  
  # Helpers
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
    
    def nros
      [1,2,3,4,5,6,7,8,9,0]
    end  

    def links operando, str, *method
      hash = {rel: operando, uri:settings.host + str}
      hash[:method] = method.first if !(method.empty?)
      hash     
    end
    
    def links_to_book id,resource_id
      vec = [links('self',"/resources/#{resource_id}/bookings/#{id}")]
      vec << links('resource',"/resources/#{resource_id}")
      vec << links('accept',"/resource/#{resource_id}/bookings/#{id}", 'PUT')
      vec << links('reject',"/resource/#{resource_id}/bookings/#{id}",'DELETE')
      vec
    end

    def links_for_bookings bookings
       bookings.each do |book|
          id = book["links"]["id"]
          resource_id = book["links"]["resource_id"]
          book["links"] = links_to_book(id,resource_id)         
        end
        bookings 
    end
    
    #validators
    def status_validator
      [:approved, :pending, :all]
    end

    def valid_date? date  #fecha con formato 'YYYY-MM-DD'
      raise unless date.is_a? String
      valid_date = false
      valid_date = true if date =~ /\d\d\d\d-\d\d-\d\d/ unless (date.empty?)
      valid_date
    end 

  end

  configure :development do
    register Sinatra::Reloader
    also_reload 'app/models/*.rb'
    also_reload 'app/controllers/*.rb'
  end
end
