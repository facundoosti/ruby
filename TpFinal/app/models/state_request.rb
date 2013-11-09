class StateRequest < ActiveRecord::Base
  
  attr_accessor :name
  attr_accessor :description
  has_and_belongs_to_many :requests

  def initialize name, description
    @name = name
    @description = description
  end
end