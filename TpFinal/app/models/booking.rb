class Booking < ActiveRecord::Base
  include ActiveModel::Validations
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

  # Class Validators 
  class DateValidator < ActiveModel::Validator
    def validate(record)
      if options[:fields].any?{|field| !(record.send(field).instance_of? Time) }
        record.errors[:base] << "This date not is Time class"
      end
    end
  end  
  
  # valdations to Email
  class UserValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
        record.errors[attribute] << (options[:message] || "is not an email")
      end
    end
 end
  

  # validations
  validates :start, presence: true 
  validates :user, presence: true, user: true 
  validates_with DateValidator, fields: [:start, :end]

end