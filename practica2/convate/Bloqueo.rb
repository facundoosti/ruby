class Bloqueo
	
	def contra una_jugada energia_vital
		una_jugada.contra_bloqueo
	end

	def contra_ataque energia_vital
		energia_vital - 10
	end

	def contra_bloqueo energia_vital
		energia_vital
	end
end