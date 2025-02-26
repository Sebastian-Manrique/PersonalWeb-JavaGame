extends AudioStreamPlayer

const musica_nivel = preload("res://assets/musica.ogg")


func poner_la_musica(musica: AudioStream, volumen: float = -0.10) -> void:
	# Solo cambia la música si la nueva música es diferente de la actual
	if stream != musica:
		stream = musica
		volume_db = volumen
		play()
	elif not playing:
		# Si la música es la misma pero no está reproduciendo, comienza a reproducirla
		play()


func poner_la_musica_nivel() -> void:
	poner_la_musica(musica_nivel)


func parar_musica() -> void:
	if playing:
		stop()
