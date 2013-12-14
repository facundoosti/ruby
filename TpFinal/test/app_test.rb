require File.expand_path(File.join('test', 'test_helper'))

describe 'Bookings app' do
  include Rack::Test::Methods

  def app
    App
  end

  describe '/resources' do
    it 'Should be to form' do
      #resources_as_json =  File.open File.join('test','cases', 'resources'), 'r'
      #Resource.create(name: 'Computadora', description: 'Notebook con 4GB de RAM y 256 GB de espacio en disco con Linux'  ) 
      #Resource.create(name: 'Monitor', description: 'Monitor de 24 pulgadas SAMSUNG' )
      get '/resources'
      assert last_response.ok?
      #assert_equal resources_as_json, last_response.body
    end  
  end
end