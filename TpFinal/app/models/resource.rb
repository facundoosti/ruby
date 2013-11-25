class Resource < ActiveRecord::Base

  # asssociations
  has_many :bookings

  #validations
  validates :name,:description,  presence: true, uniqueness: true
  validates_associated :bookings

  def links
    {rel: 'self', uri: "https//:localhost:9292/resource/#{self.id}"}
  end

  #def list_bookings limit, status, date
  #  self.bookings.joins(:status).where({ 'status.name' => status })

  #end

end