require "Ataque.rb"
require "Bloqueo.rb"
class Jugador
	
	attr_accessor :nombre
	attr_accessor :energia_vital
	attr_accessor :jugada

	def initialize nombre
		@nombre = nombre
		@energia_vital    = 100
		@jugada = []
	end

	def jugada nro_turno
		nro_turno.between? 1,10 ? jugada[nro_turno] : puts "No es un nro de turno valido"	
	end

	def atacar nro_turno
		jugada[nro_turno] = Ataque.new
	end	


	def bloquear nro_turno
		jugada[nro_turno] = Bloqueo.new
	end	

	def pi jugada_b nro_turno
		mi_jugada = jugada[nro_turno]
		energia_vital = mi_jugada.contra jugada_b, energia_vital
	end	
end