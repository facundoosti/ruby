require File.expand_path(File.join('test', 'test_helper'))

describe 'Bookings app' do
  include Rack::Test::Methods

  def app
    App
  end

  describe 'get resources' do
    it 'ra' do
      get '/resources'
      assert last_response.ok?
      #assert_equal 'Hello World', last_response.body
    end
  end
end