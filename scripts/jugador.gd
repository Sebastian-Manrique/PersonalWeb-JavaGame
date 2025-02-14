extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -400.0
const DISTANCIA_MINIMA_GENERACION = 100  # Distancia mínima entre plataformas generadas

#Todos las escenas de los titles
var tilemap_sofas = preload("res://escenas/plataformaSofas.tscn")
var tilemap_mesas = preload("res://escenas/plataformaEscalera.tscn")
var tilemap_jodo = preload("res://escenas/jodo.tscn")

var ultima_posicion_generada = Vector2.ZERO  # Rastrea dónde se generó la última plataforma


func _physics_process(delta: float) -> void:
	# Aplicar gravedad
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Detectar si está sobre una plataforma específica y generar nuevas plataformas
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		if collider is StaticBody2D:
			print("Sobre una plataforma:", collider.name)
			generar_plataforma(collider)

	# Salto
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movimiento horizontal
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func generar_plataforma(collider: StaticBody2D) -> void:
	var distancia = global_position.distance_to(ultima_posicion_generada)
	if distancia < DISTANCIA_MINIMA_GENERACION:
		return  # Evita generar plataformas demasiado cerca

	var nueva_plataforma
	var rng = RandomNumberGenerator.new()
	var mapa = rng.randi_range(1, 3)
	print(mapa)

	if mapa == 1:
		nueva_plataforma = tilemap_sofas.instantiate()
	elif mapa == 2:
		nueva_plataforma = tilemap_mesas.instantiate()
	elif mapa == 3:
		nueva_plataforma = tilemap_jodo.instantiate()

	# Ubicar la nueva plataforma más adelante en la dirección del movimiento
	var nueva_posicion = global_position + Vector2(0, -50)  # Genera plataformas más arriba
	nueva_plataforma.position = nueva_posicion

	get_parent().add_child(nueva_plataforma)
	ultima_posicion_generada = nueva_posicion  # Actualiza la última posición generada
