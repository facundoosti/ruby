class Ataque

	def contra una_jugada energia_vital
		una_jugada.contraAtaque
	end

	def contra_ataque energia_vital
		energia_vital * 0.8
	end

	def contra_bloqueo energia_vital
		energia_vital
	end
end