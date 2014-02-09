require File.expand_path(File.join('test', 'test_helper'))
require 'resource'

describe '/resources' do

  pattern = {
              resources: [
              ].forgiving!,
              links: [
                {
                  rel: 'self',
                  uri: /\Ahttp?\:\/\/.*\z/i
                }
              ]
            }

  server_response = get '/resources'

  describe 'When resources are listed' do

    it 'Should return a body with format' do
      server_response.body.must_match_json_expression(pattern)
    end

    it 'Should return Status 200 OK' do
      assert server_response.ok?
    end

  end
end


describe '/resources/:id_resource' do

  resource = Resource.create name: 'Resource', description: 'Description of Resource'

  describe 'When request a resource' do

    pattern = {
                resource: {
                name: String,
                description: String,
                links: [
                  {
                    rel: 'self',
                    uri: "http://localhost:9292/resources/#{resource.id}"
                  },
                  {
                    rel: 'bookings',
                    uri: "http://localhost:9292/resources/#{resource.id}/bookings"
                  }
                ]
              }
            }

  
    server_response = get "/resources/#{resource.id}" 
    
    it 'Should return a body with format' do
      server_response.body.must_match_json_expression(pattern)
    end

    it 'Should return Status 200 OK' do
      assert server_response.ok?
    end

  end

  describe 'When request a resource not found' do
    server_response = get "/resources/1000"  
    
    it 'Should return Status 404 Not Found' do
      assert server_response.not_found?
    end  
  end
end

=begin
describe '/resources/:id_resource/bookings/:id_booking' do 
  describe 'When there is a reserve' do
    it 'Should removed' do
      resource=Resource.create name: 'Recurso', description: "Descripcion del Recurso"
      b = resource.bookings.create start: Time.now, end: Time.now
      delete "/resources/'#{resource.id}'/bookings/'#{b.id}'"
      assert last_response.ok?
    end
  end
end
=end

describe '#delete' do 
  describe '/resources/:id_resource/bookings/:id_booking' do 
    resource=Resource.create name: 'delete', description: "Descripcion delete"
    booking = resource.bookings.create start: Time.now, end: Time.now
    
    server_response = delete "/resources/#{resource.id}/bookings/#{booking.id}" 

    describe 'When a reservation is canceled' do
      it 'the body should be empty' do
        server_response.body.must_be_empty   
      end
      it 'the status should be 200 OK' do
        assert server_response.ok?  
      end
    end

=begin    describe 'When a reservation is not canceled' do
      server_response = delete "/resources/#{resource.id}/bookings/#{booking.id}" 
      it 'the body should be 404 Not Found' do
        assert server_response.not_found?
      end
    end
=end      
  end
end  

describe '#View a booking' do 
  describe '/resources/:id_resource/bookings/:id_booking' do 
    resource=Resource.create name: 'test8', description: "test8"
    booking = resource.bookings.create start: Time.now, end: Time.now
    pattern = {
                from: /\A\d\d\d\d-\d\d-\d\d\z/,
                to: /\A\d\d\d\d-\d\d-\d\d\z/,
                status: ['pending','approved'],
                links: [
                  {
                    rel: "self",
                    url: "http://localhost:9292/resources/#{resource.id}/bookings/#{booking.id}"
                  },
                  {
                    rel: "resource",
                    uri: "http://localhost:9292/resource/#{resource.id}",
                  },
                  {
                    rel: "accept",
                    uri: "http://localhost:9292/resource/#{resource.id}/bookings/#{booking.id}",
                    method: "PUT"
                  },
                  {
                    rel: "reject",
                    uri: "http://localhost:9292/resource/#{resource.id}/bookings/#{booking.id}",
                    method: "DELETE"
                  }
                ]
              }

      server_response = get "/resources/#{resource.id}/bookings/#{booking.id}"  
      raise server_response.body
      it 'Should return a body with format' do
        server_response.body.must_match_json_expression(pattern)
      end

      it 'Should return Status 200 OK' do
        assert server_response.ok?
      end

      describe 'When request a resource not found' do
        server_response = get "/resources/1000/bookings/1000"  
        
        it 'Should return Status 404 Not Found' do
          assert server_response.not_found?
        end  
      end
  end  
end    





