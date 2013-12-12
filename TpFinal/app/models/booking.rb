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
    {id:self.id,resource_id:self.resource.id}
  end
  
  # validations
  validates :start, presence: true 
end