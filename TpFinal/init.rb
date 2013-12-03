require 'bundler'
Bundler.require

require 'time'

#require la aplicacion
require './app/app'

#require los controladores
Dir['./app/controllers/*.rb'].sort.each { |req| require_relative req }

#require los modelos
Dir['./app/models/*.rb'].sort.each { |req| require_relative req }