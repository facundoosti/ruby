require File.expand_path(File.join('test', 'minitest_helper'))
require 'request'

describe 'request' do
  let (:request) { Request.new }

  describe '#new' do
    describe '' do
      it '' do
        request.valid?.must_equal false
      end
    end
  end
end