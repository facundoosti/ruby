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

def palindromo? num
	if num.to_s.size % 2 == 0
		primera_mitad = num.to_s[0, num.to_s.size / 2]
		segunda_mitad = num.to_s[num.to_s.size / 2 , num.to_s.size + 1].reverse
		primera_mitad == segunda_mitad
	end
end



#ejercicio 4
def nro_divisible
	a=[]
	(1..3000).each do |e|
	 	if (1..10).all? {|r| (e % r == 0)  }
	 		a.push e
	 		break
	 	end	
	end
	a.first
end
#ejercicio 5
def resta
	(1..100).inject  {|s,m| s + m}**2 - (1..100).inject  {|s,m| s + m**2} 
end
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



