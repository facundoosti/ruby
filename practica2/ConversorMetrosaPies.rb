#ejercicio 11

def metros_a_pies medida
	ft = medida.to_i * 32808
end

def pies_a_metros medida
	mm = medida.to_i / 32808
end

def menu_principal
	print 	"1.-Convertir de metros a pies
2.-Convertir de pues a metros\n"
		loop { 
			print "Ingrese nro de Operacion:"
			STDOUT.flush  
			operacion = gets.chomp
			case operacion
			                when "1" then 
			                	print "Ingrese valor:" 
								STDOUT.flush
								dato = gets.chomp    
								puts metros_a_pies dato
			                	break
			                when "2" then puts pies_a_metros dato	
			                	print "Ingrese valor:" 
								STDOUT.flush
								dato = gets.chomp    
								puts metros_a_pies dato
								break
			                else   
			                	puts "La operacion es incorrecta...\n"  		
			end
		}	
	end	