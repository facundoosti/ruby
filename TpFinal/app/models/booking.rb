class Booking < ActiveRecord::Base
  
  # associations
  belongs_to :resource
  belongs_to :status, class_name: "StatusBooking"
                      

  #methods

  # validations
  validates :start, presence: true 
 

end