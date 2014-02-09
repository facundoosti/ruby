  require File.expand_path(File.join('test', 'test_helper'))
  # test Helpers

  describe '#status_validator' do
    describe 'when argument is all' do
      it 'should return true' do
        status_validator('all').must_equal true
      end
    end
    describe 'when argument is approved' do
      it 'should return true' do
        status_validator('approved').must_equal true
      end
    end
    describe 'when argument is pending' do
      it 'should return true' do
        status_validator('pending').must_equal true
      end
    end
    describe 'when argument not exist in array' do
      it 'should return false' do
        status_validator('zaraza').wont_equal true
      end
    end
  end

  describe '#valid_date?' do
    describe 'when argument is a String' do
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
