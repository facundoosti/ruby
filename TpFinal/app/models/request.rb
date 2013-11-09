class Request < ActiveRecord::Base
  # accessors
  attr_accessor :occupancy_date, :disoccupation_date, :resource

  # associations
  belongs_to :resource
  belongs_to :state_request 

  # validations
  validates :occupancy_date, presence: true
  validates :disoccupation_date, presence: true
  validates_associated :state_request
  validates_associated :resource
end