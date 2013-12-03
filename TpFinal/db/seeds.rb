require './init'

r=Resource.create(name: 'sala de conferencias', description: "Sala en donde se realizan las conferencias en la organizacion" ) 
5.times do |num|
  Resource.create(name: "Pc #{num}", description: "Computadora Personal #{num}")
end
Booking.create({start: Time.now, :end => Time.now ,resource: r })
Booking.create({start: Time.now, :end => Time.now ,resource: r  })


b1 = Booking.create({start: Time.new(2013,11,13,11,0,0), end:Time.new(2013,11,13,12,0,0), resource: r})
b1.status = 'approved'
b1.save
Booking.create({start: Time.new(2013,11,13,14,0,0), end:Time.new(2013,11,13,15,0,0), resource: r})

b2 =Booking.create({start: Time.new(2013,11,14,11,0,0), end:Time.new(2013,11,14,14,0,0), resource: r})
b2.status = 'approved'
b2.save