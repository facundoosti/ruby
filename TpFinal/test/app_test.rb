  require File.expand_path(File.join('test', 'test_helper'))

  describe 'Bookings app' do
  include Rack::Test::Methods
  include Helpers  
  def app
    App
  end

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

    describe 'when add a resource' do
      it 'should return add one to the size of the array' do 
        Resource.create name: 'Recurso', description: "Descripcion del Recurso" 
        get '/resources'
        response = JSON.parse last_response.body
        response["resources"].size.must_equal 1 
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
  
  
  #test Helpers

  describe '#a_time' do 
    describe "when argument is a string whithin format 'YYYY-MM-DD'" do
      it 'should return a date' do
        date = a_time('2013-12-01')
        date.must_be_instance_of Time
      end  
    end   
  end

  describe '#status_validator' do 
    describe "when argument is all" do
      it 'should return true' do
        status_validator('all').must_equal true
      end
    end
    describe "when argument is approved" do
      it 'should return true' do
        status_validator('approved').must_equal true
      end
    end
    describe "when argument is pending" do
      it 'should return true' do
        status_validator('pending').must_equal true
      end
    end
    describe "when argument not exist in array" do
      it 'should return false' do
        status_validator('zaraza').wont_equal true
      end
    end
  end

  describe '#valid_date?' do 
    describe "when argument is a String" do
      it "should return true if it satisfies the condition 'YYYY-MM-DD'" do
        valid_date?('2013-22-22').must_equal true
      end
      it "should return false if it's not satisfies the condition 'YYYY-MM-DD'" do
        valid_date?('2013-22--22').wont_equal true
      end
        it "should return false if it's not satisfies the condition 'YYYY-MM-DD'" do
        valid_date?('2013-22-22-21').must_equal false
      end
      it "should return false if it's not number" do
        valid_date?('2013-22-2L').wont_equal true
      end
    end
  end

    
        

end