class Resource < ActiveRecord::Base

  # asssociations
  has_many :requests

  #validations
  validates :name,:description,  presence: true, uniqueness: true
  validates_associated :requests

end