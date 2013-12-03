require 'bundler'
Bundler.require
require_relative './app/app'

Dir['./app/controllers/*.rb'].sort.each { |req| require_relative req }