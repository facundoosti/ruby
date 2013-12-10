class Resource < ActiveRecord::Base
  # asssociations
  has_many :bookings

  #validations
  validates :name,:description,  presence: true, uniqueness: true
  validates_associated :bookings

  def links
    [{rel: 'self', uri: "https//:localhost:9292/resources/#{self.id}"}]
  end

  def available_to_book?(from, to)
    result = bookings.where(status: 'approved').
                      where('start >= ? AND end <= ? OR start >= ? AND end <= ?', from, from, to, to)
    result.empty?
  end

  def cancel_pending_bookings
    bookings.where(status: 'pending').destroy_all
  end
end