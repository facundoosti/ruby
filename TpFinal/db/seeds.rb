require './init'

r=Resource.create(name: 'sala de conferencias', description: "Sala en donde se realizan las conferencias en la organizacion" ) 
5.times do |num|
  Resource.create(name: "Pc #{num}", description: "Computadora Personal #{num}")
end
a = StatusBooking.create(name: 'approved'  , description: 'Request approved')
b= StatusBooking.create(name: 'pending', description: 'Request in pending')
Booking.create({start: Time.now, :end => Time.now ,status: a,resource: r  })
Booking.create({start: Time.now, :end => Time.now ,status: b,resource: r  })

