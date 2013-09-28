require_relative "Product.rb"
class Purchase
	
	attr_accessor :product_list
	attr_accessor :orden_de_compra
	attr_accessor :total

	def initialize list
		@product_list    = list
		@orden_de_compra = []
		@total = 0
	end
	
	def add product_name
		a_product = product_list.list.find { |elem| elem.nombre == product_name}
		puts a_product.nombre
		if a_product.nil?
			orden_de_compra.push a_product
			puts "done."
		else
			puts "El producto no existe..."
		end		
	end

	def total
		total = orden_de_compra.inject { |total, product| total + product.precio }		
	 	if total.to_i > 200
	 		total = total * 0.9
	 	end
	 	cant = orden_de_compra.count {|product| product.nombre =='Historias de sillar' }
	 	if cant >= 2
	 		puts "desuento- #{cant}  Historias de sillar"
	 		total = total - cant * 10
	 	end	
	end
end