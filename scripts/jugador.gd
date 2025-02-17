extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -400.0
const DISTANCIA_MINIMA_GENERACION = 100  # Distancia mínima entre plataformas generadas
const TOLERANCIA_POSICION = 50  # Aumenté el margen de tolerancia para la comparación de posiciones

# Todos las escenas de los tiles
var tilemap_sofas = preload("res://escenas/plataformaSofas.tscn")
var tilemap_mesas = preload("res://escenas/plataformaTablon.tscn")
var tilemap_jodo = preload("res://escenas/jodo.tscn")
var tilemap_mesasMovibles = preload("res://escenas/plataformasMesas.tscn")

var ultima_posicion_generada = Vector2.ZERO  # Rastrea dónde se generó la última plataforma
var plataformas_generadas = {}  # Diccionario para almacenar las posiciones de las plataformas generadas
var ya_pisada = false  # Bandera para controlar que se imprima solo una vez el mensaje


# Redondear la posición a un valor más cercano (evitar problemas con la precisión)
func redondear_posicion(pos: Vector2) -> Vector2:
	return Vector2(round(pos.x / TOLERANCIA_POSICION) * TOLERANCIA_POSICION, round(pos.y / TOLERANCIA_POSICION) * TOLERANCIA_POSICION)


func _physics_process(delta: float) -> void:
	# Aplicar gravedad
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Detectar si está sobre una plataforma específica y generar nuevas plataformas
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		if collider.name == "mesa":
			pass
		elif collider.name == "ground":
			pass  # Ignorar el "ground", no generar plataformas sobre él
		# Redondear la posición del collider para una comparación más precisa
		var pos_redondeada = redondear_posicion(collider.position)

		# Verificar si la posición del collider ya fue registrada en plataformas_generadas
		if plataformas_generadas.has(pos_redondeada):
			pass  # No generar plataforma si ya existe en esa posición
		elif collider is StaticBody2D and collider.name != "ground":
			# Asegurarse de que el mensaje solo se imprima una vez
			if not ya_pisada:
				print("Sobre una plataforma:", collider.name, "posicion ", pos_redondeada, "\nPlataformas: ", plataformas_generadas)
				ya_pisada = true  # Marcar que se ha impreso el mensaje una vez
			generar_plataforma(collider)

	# Restablecer la bandera después de que el personaje deje de estar sobre la plataforma
	if not is_on_floor() and ya_pisada:
		ya_pisada = false  # Solo restablecer si no estamos tocando una plataforma

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

	# Generar la nueva plataforma
	var nueva_posicion = global_position + Vector2(0, -50)  # Genera plataformas más arriba
	var nueva_posicion_redondeada = redondear_posicion(nueva_posicion)
	if plataformas_generadas.has(nueva_posicion_redondeada):
		return  # Evita generar una nueva plataforma en una posición ya ocupada

	# Generar la nueva plataforma
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

	# Ubicar la nueva plataforma
	nueva_plataforma.position = nueva_posicion_redondeada

	# Agregar la plataforma al padre y registrar su posición
	get_parent().add_child(nueva_plataforma)
	plataformas_generadas[nueva_posicion_redondeada] = nueva_plataforma  # Registrar la posición de la plataforma
	ultima_posicion_generada = nueva_posicion_redondeada  # Actualiza la última posición generada
