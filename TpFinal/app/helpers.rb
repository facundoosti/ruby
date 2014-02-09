module Helpers

  def nros
    [1,2,3,4,5,6,7,8,9,0]
  end  

  def host
    request.scheme + "://" +request.host + ":" + request.port.to_s
  end 
    
  def links operando, str, *method
    hash = {rel: operando, uri:host + str}
    hash[:method] = method.first unless (method.empty?)
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
  def status_validator status
    [:approved, :pending, :all].include? status.to_sym
  end

  def valid_date? date  #fecha con formato 'YYYY-MM-DD'
    raise unless date.is_a? String
    valid_date = false
    valid_date = true if date =~ /\A\d\d\d\d-\d\d-\d\d\z/ unless (date.empty?)
    valid_date
  end
end