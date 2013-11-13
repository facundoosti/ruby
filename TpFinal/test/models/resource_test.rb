require File.expand_path(File.join('test', 'minitest_helper'))
require 'resource'

describe 'resource' do
  let (:resource) { Resource.create }


  describe '#create' do
    describe 'when required attributes are not present' do
      it 'valid? is false' do
        resource.valid?.must_equal false
      end
    end

    describe 'when required attributes are present' do
      it 'valid? is true' do
        resource = Resource.create(name: 'sala de conferencias', description: "Sala en donde se realizan las conferencias en la organizacion" ) 
        resource.valid?.must_equal true
      end
    end  
  end
end