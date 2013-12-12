require 'bundler'
ENV['RACK_ENV'] = 'test'

Bundler.require :default, ENV['RACK_ENV'].to_sym
require File.expand_path(File.join('init'))
require 'minitest/autorun'
require 'minitest/spec'

def setup
  DatabaseCleaner.start
end

def teardown
  DatabaseCleaner.clean
end

DatabaseCleaner.strategy = :transaction