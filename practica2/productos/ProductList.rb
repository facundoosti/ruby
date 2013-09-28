require_relative "Product.rb"
class ProductList

	attr_accessor :list

	def initialize
		@list = []
	end

	def read_file file
		file = "./productos/sample.txt"
		if File.exist?(file)
	    	File.open(file).each do |linea|
	    		product = linea.split(",")
	    		nro_product = product[0]
	    		name = product[1]
	    		precio = product[2]
	    		list.push Product.new nro_product, name, precio
	    		puts "done."
	    	end
	    else
	    	puts "El archivo o la ruta no existe....."
	    end	
	end	

	def print_product a_product
		puts "Numero: 				#{a_product.nro}"
		puts "Nombre:  				#{a_product.nombre}"
		puts "Precio:               #{a_product.precio}"
		puts "-------------------------------------------------------"		
	end

	def all
		list.each {|product| print_product product}
	end
end