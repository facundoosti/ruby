require File.expand_path(File.join('test', 'minitest_helper'))
require 'resource_controller'

describe '/resources/:id_resource/bookings' do

  describe '#post' do
    describe 'when required attributes are not present' do
      it '' do
        {}.must_be_empty
      end
    end  
  end
end