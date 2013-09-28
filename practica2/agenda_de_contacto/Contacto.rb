class Contact
	attr_accessor :nombre
	attr_accessor :fecha_de_nacimiento
	attr_accessor :email
	attr_accessor :telefono
	attr_accessor :direccion

	def initialize nombre, fecha_de_nacimiento, email, telefono, direccion
		@nombre = nombre
		@fecha_de_nacimiento = fecha_de_nacimiento
		@email = email
		@telefono = telefono
		@direccion = direccion
	end

	def update estuct
		estruct.each {|key, value| key = value  }
	end
end