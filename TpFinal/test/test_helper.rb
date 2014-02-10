require 'bundler'
ENV['RACK_ENV'] = 'test'

Bundler.require :default, ENV['RACK_ENV'].to_sym
require File.expand_path(File.join('init'))
require_relative '../app/helpers.rb'

require 'time'

#DatabaseCleaner.strategy = :transaction

#class MiniTest::Spec
class Minitest::Spec
  #before do
  #  DatabaseCleaner.start
  #end

  #after do
  #  DatabaseCleaner.clean
  #end

  before do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end
end
