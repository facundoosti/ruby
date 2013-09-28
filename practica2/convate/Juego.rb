require 'Jugador.rb' 
class Juego
	

	def determinar_ganador jugador_a, jugador_b

		10.times do |nro_turno|
				jugador_a.pi(jugador_b.jugada[nro_turno], nro_turno)
				jugador_b.pi(jugador_a.jugada[nro_turno], nro_turno)
		end	
		if jugador_a > jugador_b
			"gana a"	
		elsif jugador_b > jugador_a
			"gana b"
		else
			"empatan"				
		end
	end		
end