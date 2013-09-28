#ejercicio 1
	
def es_multiplo_de_3 un_nro
	un_nro % 3 == 0 	
end

def es_multiplo_de_5 un_nro
	un_nro % 5 == 0 	
end

def suma_mult_3y5_hasta limite
	suma = 0
	limite.times do |x| 
		if es_multiplo_de_5 x or es_multiplo_de_3 x 
			suma += x
		end
	end	
	puts "suma: #{suma}"
end

#ejercicio 2

def fibonacci
	fib = Enumerator.new do |y|
	  a = 1 
	  b = 2
	  loop do
	    y << a
	    a, b = b, a + b
	  end
	end
end

def fib num
	p fibonacci.take(num).select {|e| e.even?}.inject { |sum, n| sum + n}
end

#ejercicio 3
#ejercicio 4
#ejercicio 5

#ejercicio 6
def primo num 
	Prime.first(num).last
end


#ejercicio 7
def primos_menores_a num 
	Prime.each(num).inject{|sum, n| sum + n}
end

#ejercicio 8

def numerar(a)
	lista = []
	a.each { |e| lista << e.length}
	lista
end 

#ejercicio 9a

def calcular_entero_dado un_color
	un_color[:red] + un_color[:green]*256 + un_color[:blue]*256**2
end

#ejercicio 9b



