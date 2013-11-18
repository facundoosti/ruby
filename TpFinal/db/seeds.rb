require './init'

Resource.create(name: 'sala de conferencias', description: "Sala en donde se realizan las conferencias en la organizacion" ) 
5.times do |num|
  Resource.create(name: "Pc #{num}", description: "Computadora Personal #{num}")
end
StateBooking.create(name: 'approved'  , description: 'Request approved')
StateBooking.create(name: 'refuse' , description: 'Request refuded')
StateBooking.create(name: 'pending', description: 'Request in pending')

