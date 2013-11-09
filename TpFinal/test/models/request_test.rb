require File.expand_path(File.join('test', 'minitest_helper'))
require 'request'

describe 'request' do
  let (:request) { Request.new }

  describe '#new' do
    describe 'when required attributes are not present' do
      it 'valid? is false' do
        request.valid?.must_equal false
      end
    end
  end
end