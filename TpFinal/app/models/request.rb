class Request < ActiveRecord::Base
  
  # associations
  belongs_to :resource
  belongs_to :state_request 

  #methods
 # def bookings_with(resource_id,date,limit,status)
 #   Request.where(resource_id: resource_id).where({ date: (occupancy_date:)..disoccupation_date: }).take(30)
    
#  end


  # validations
  validates :occupancy_date, presence: true 
 

end