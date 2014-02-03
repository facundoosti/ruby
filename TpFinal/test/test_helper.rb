require 'bundler'
ENV['RACK_ENV'] = 'test'

Bundler.require :default, ENV['RACK_ENV'].to_sym
require File.expand_path(File.join('init'))
require_relative '../app/helpers.rb'

require 'minitest/autorun'
require 'minitest/spec'
require 'time'

DatabaseCleaner.strategy = :transaction

class MiniTest::Spec
  include FactoryGirl::Syntax::Methods
  FactoryGirl.find_definitions
  
  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
end

