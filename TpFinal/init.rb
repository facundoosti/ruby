require 'bundler'
Bundler.require

require './app/app'

Dir['./app/controllers/*.rb'].sort.each { |req| require_relative req }