  require File.expand_path(File.join('test', 'test_helper'))

  describe '/resources' do
    describe 'When resources are not loaded' do
      it 'Should return in resources: empty array' do
        resources_empty = {resources:[], links:[{rel: "self",uri: "http://localhost:9292/resources"}]}
        get '/resources'
        
        assert last_response.ok?

        response = JSON.parse last_response.body
        assert_instance_of Array, response["resources"]
        
        assert resources_empty.to_json, last_response.body
      end  
    end
  end

  describe '/resources/:id_resource' do
    describe 'When request a resource' do
      it 'Should return that resource' do
        resource=Resource.create name: 'Recurso', description: "Descripcion del Recurso"
        Resource.create name: 'Recurso1', description: "Descripcion del Recurso1"
        get '/resources/',  {:id_resource => resource.id}
        r=Resource.find_by(name:'Recurso') 
        r.must_equal Resource.find resource.id #(params[:id_resource])
      end
    end
  end
  
  describe '/resources/:id_resource/bookings/:id_booking' do #delte
    describe 'When there is a reserve' do
      it 'Should removed' do
        resource=Resource.create name: 'Recurso', description: "Descripcion del Recurso"
        b = resource.bookings.create start: Time.now, end: Time.now
        delete '/resources/',  {:id_resource => resource.id, :id_booking => b.id}
        assert last_response.ok?
      end
    end
  end   
  

    
        
