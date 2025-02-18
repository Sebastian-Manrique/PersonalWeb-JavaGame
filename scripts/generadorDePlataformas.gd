extends StaticBody2D

var tocado = false
var tilemap_sofas = preload("res://escenas/plataformaSofas.tscn")
var tilemap_mesas = preload("res://escenas/plataformaTablon.tscn")
var tilemap_jodo = preload("res://escenas/jodo.tscn")
var tilemap_mesasMovibles = preload("res://escenas/plataformasMesas.tscn")

var plataformas_generadas = {}
var ultima_posicion_generada = Vector2.ZERO
const DISTANCIA_MINIMA_GENERACION = 100
const TOLERANCIA_POSICION = 50


func redondear_posicion(pos: Vector2) -> Vector2:
	return Vector2(round(pos.x / TOLERANCIA_POSICION) * TOLERANCIA_POSICION, round(pos.y / TOLERANCIA_POSICION) * TOLERANCIA_POSICION)


func _on_body_entered(body):
	print("Tocado")
	if body.is_in_group("jugador") and not tocado:
		generar_plataforma()
		tocado = true


func generar_plataforma() -> void:
	if ultima_posicion_generada == Vector2.ZERO:  # Si es la primera vez
		ultima_posicion_generada = global_position

	var distancia = global_position.distance_to(ultima_posicion_generada)
	print("Distancia desde la última plataforma:", distancia)

	if distancia < DISTANCIA_MINIMA_GENERACION:
		print("Plataforma demasiado cerca, no generada.")
		return

	var nueva_posicion = global_position + Vector2(0, -50)
	var nueva_posicion_redondeada = redondear_posicion(nueva_posicion)

	if plataformas_generadas.has(nueva_posicion_redondeada):
		print("Ya hay una plataforma en esta posición.")
		return

	var nueva_plataforma
	var rng = RandomNumberGenerator.new()
	var mapa = rng.randi_range(1, 4)

	if mapa == 1:
		nueva_plataforma = tilemap_sofas.instantiate()
	elif mapa == 2:
		nueva_plataforma = tilemap_mesas.instantiate()
	elif mapa == 3:
		nueva_plataforma = tilemap_jodo.instantiate()
	elif mapa == 4:
		nueva_plataforma = tilemap_mesasMovibles.instantiate()

	nueva_plataforma.position = nueva_posicion_redondeada
	get_parent().add_child(nueva_plataforma)

	plataformas_generadas[nueva_posicion_redondeada] = nueva_plataforma
	ultima_posicion_generada = nueva_posicion_redondeada

	print("Plataforma generada en:", nueva_posicion_redondeada)
