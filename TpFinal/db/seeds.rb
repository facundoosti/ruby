require './init'

Resource.create(name: 'sala de conferencias', description: "Sala en donde se realizan las conferencias en la organizacion" ) 
5.times do |num|
  Resource.create(name: "Pc #{num}", description: "Computadora Personal #{num}")
end
StateRequest.create(name: 'Acept'  , description: 'Request accepted')
StateRequest.create(name: 'Refuse' , description: 'Request refuded')
StateRequest.create(name: 'Standby', description: 'Request in standby')

