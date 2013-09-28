require_relative './Contacto.rb'
class Agenda

	attr_accessor :list

	def initialize
		@list = []
	end
	
	def print_contact a_contact
		puts "NOMBRE: 				#{a_contact.nombre}"
		puts "FECHA_DE_NACIMIENTO:  #{a_contact.fecha_de_nacimiento}"
		puts "EMAIL:                #{a_contact.email}"
		puts "TELEFONO:             #{a_contact.telefono}"
		puts "DIRECCION:            #{a_contact.direccion}"
		puts "-------------------------------------------------------"		
	end

	def all
		if list.empty?
			puts "No hay contactos..."
		else	
		 	 list.each {|contact| print_contact contact}
		end  
	end
	
	def add contact
		list.push contact
	end

	def find nombre
		list.find { |e| e.nombre = nombre }
		print_contact contact  
	end		

	def update nombre, estruct # estruct = {key: "value"}
		contact = list.find { |e| e.nombre = nombre }
		contact.estruct
	end
end