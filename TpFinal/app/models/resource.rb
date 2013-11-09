class Resource < ActiveRecord::Base
  # accessors
  attr_accessor :name, :description

  # asssociations
  has_and_belongs_to_many :requests
  has_one :state_resource
end