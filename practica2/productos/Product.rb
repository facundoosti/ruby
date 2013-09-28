class Product
	
	attr_accessor :nro
	attr_accessor :nombre
	attr_accessor :precio

	def initialize nro, nombre, precio
		@nro    = nro
		@nombre = nombre
		@precio = precio
	end
	
end