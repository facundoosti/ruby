class Booking < ActiveRecord::Base
  extend Enumerize

  enumerize :status, in: [:approved, :pending], default: :pending

  # associations
  belongs_to :resource
                      
  #methods
  def whith_status status
    (self.status == status) || (status == 'all')
  end

  def links
    [{
          rel: "self",
          uri: "http://localhost:9292/resources/#{self.resource.id}/bookings/#{self.id}"
        },
        {
          rel: "resource",
          uri: "http://localhost:9292/resources/#{self.resource.id}"
        },
        {
          rel: "accept",
          uri: "http://localhost:9292/resource/#{self.resource.id}/bookings/#{self.id}",
          method: "PUT"
        },
        {
          rel: "reject",
          uri: "http://localhost:9292/resource/#{self.resource.id}/bookings/#{self.id}",
          method: "DELETE"
        }]
  end
  # validations
  validates :start, presence: true 
end