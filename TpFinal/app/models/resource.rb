class Resource < ActiveRecord::Base
  # asssociations
  has_many :bookings

  #methods
  def links
    self.id
  end

  def available_to_book?(from, to)
    result = bookings.where(status: 'approved').
                      where('start >= ? AND end <= ? OR start >= ? AND end <= ?', from, from, to, to)
    result.empty?
  end

  def cancel_pending_bookings
    bookings.where(status: 'pending').destroy_all
  end
  
  def bookings_since_to date, limit
    bookings.order(:start).where('start >= ? AND start <= ?',date,limit)  
  end

  #validations
  validates :name,:description,  presence: true, uniqueness: true
  validates_associated :bookings

end