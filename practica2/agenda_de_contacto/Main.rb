#Main
require_relative 'Agenda.rb'

def add_contact agenda
	
	agenda.add contact
end

def update_contact
	
end

def search_contact
	
end

def menu_principal 
	agenda = Agenda.new
	
	loop { 
		print 	"1.-Ver todos los contactos
2.-Agregar un contacto
3.-Editar un contacto
4.-Buscar un contacto\n
Ingrese nro de operacion:"
		STDOUT.flush  
	    operacion = gets.chomp
		case operacion
		                when "1" then agenda.all
		                when "2" then add_contact contact
		                when "3" then update_contact
		                when "4" then search_contact	
		                else   
		                	puts "La operacion es incorrecta..." 
		                	p "Ingrese Enter para volver al menu..."   
		                	operacion = gets.chomp           	
		
		end
	}	
end