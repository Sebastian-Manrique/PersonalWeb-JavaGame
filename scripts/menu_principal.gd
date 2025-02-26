extends Control


func _ready() -> void:
	AudioPlayer.poner_la_musica_nivel()


func _on_jugar_pressed() -> void:
	get_tree().change_scene_to_file("res://escenas/principal.tscn")


func _on_musica_pressed() -> void:
	var play_icon = preload("res://assets/musica.png")
	var stop_icon = preload("res://assets/sinMusica.png")
	var musica_button = $MarginContainer/VBoxContainer/musica
	if AudioPlayer.playing:
		AudioPlayer.parar_musica()
		musica_button.icon = stop_icon
	else:
		AudioPlayer.poner_la_musica_nivel()
		musica_button.icon = play_icon


func _on_cerrar_pressed() -> void:
	get_tree().quit()  # Cierro el juego, facilito
