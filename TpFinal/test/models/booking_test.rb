require File.expand_path(File.join('test', 'test_helper'))
require 'booking'
require 'resource'

describe 'booking' do
  #let (:resource) { FactoryGirl.create :resource }
  let (:booking) { Booking.create }
  let (:other_booking) { 
      r = Resource.create name: 'Recurso', description: "Descripcion del Recurso"  
      Booking.create start: Time.new(2013,01,13,11,0,0), :end => Time.new(2013,01,13,12,0,0) ,user:'user@user', resource: r  
    }

  describe '#create' do
    describe 'when required attributes are not present' do
      it 'valid? is false' do
        booking.valid?.must_equal false
      end
    end

    describe 'when required attributes are present' do
      it 'valid? is true' do  
        r = Resource.create name: 'Recurso1', description: "Descripcion del Recurso1"  
        other_booking=Booking.create(start: Time.new(2013,01,13,11,0,0), :end => Time.new(2013,01,13,12,0,0) ,user:'user@user', resource: r)  
        other_booking.valid?.must_equal true
      end
    end   
  end
  
  


end  