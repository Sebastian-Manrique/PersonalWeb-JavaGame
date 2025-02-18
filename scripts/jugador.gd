extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -400.0
const DISTANCIA_MINIMA_GENERACION = 100
const TOLERANCIA_POSICION = 50
const COYOTE_TIME = 0.2  # Tiempo extra para poder saltar tras caer

var tilemap_sofas = preload("res://escenas/plataformaSofas.tscn")
var tilemap_mesas = preload("res://escenas/plataformaTablon.tscn")
var tilemap_jodo = preload("res://escenas/jodo.tscn")
var tilemap_mesasMovibles = preload("res://escenas/plataformasMesas.tscn")

var ultima_posicion_generada = Vector2.ZERO
var plataformas_generadas = {}
var ya_pisada = false

var coyote_time_timer = 0.0
var puede_saltar = false


func redondear_posicion(pos: Vector2) -> Vector2:
	return Vector2(round(pos.x / TOLERANCIA_POSICION) * TOLERANCIA_POSICION, round(pos.y / TOLERANCIA_POSICION) * TOLERANCIA_POSICION)


func _physics_process(delta: float) -> void:
	if is_on_floor():
		add_to_group("jugador")
		coyote_time_timer = COYOTE_TIME
		puede_saltar = true
	else:
		coyote_time_timer -= delta
		if coyote_time_timer <= 0:
			puede_saltar = false

	if not is_on_floor():
		velocity += get_gravity() * delta

	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		#if collider.name == "movible_mesa" or collider.name == "ground":
		#continue
#
	#var pos_redondeada = redondear_posicion(collider.position)
#
	#if plataformas_generadas.has(pos_redondeada):
	#pass
	#elif collider is StaticBody2D and collider.name != "ground":
	#if not ya_pisada:
	#print("Sobre una plataforma: ", collider.name, ", posicion ", pos_redondeada, "\nPlataformas: ", plataformas_generadas)
	#ya_pisada = true
	##generar_plataforma(collider)

	if not is_on_floor() and ya_pisada:
		ya_pisada = false

	if Input.is_action_just_pressed("ui_accept") and puede_saltar:
		velocity.y = JUMP_VELOCITY
		puede_saltar = false  # Evita que se siga saltando después del tiempo de coyote

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

#func generar_plataforma(collider: StaticBody2D) -> void:
#var distancia = global_position.distance_to(ultima_posicion_generada)
#if distancia < DISTANCIA_MINIMA_GENERACION:
#return
#
#var nueva_posicion = global_position + Vector2(0, -50)
#var nueva_posicion_redondeada = redondear_posicion(nueva_posicion)
#if plataformas_generadas.has(nueva_posicion_redondeada):
#return
#
#var nueva_plataforma
#var rng = RandomNumberGenerator.new()
#var mapa = rng.randi_range(1, 4)
#
#if mapa == 1:
#nueva_plataforma = tilemap_sofas.instantiate()
#elif mapa == 2:
#nueva_plataforma = tilemap_mesas.instantiate()
#elif mapa == 3:
#nueva_plataforma = tilemap_jodo.instantiate()
#elif mapa == 4:
#nueva_plataforma = tilemap_mesasMovibles.instantiate()
#
#nueva_plataforma.position = nueva_posicion_redondeada
#get_parent().add_child(nueva_plataforma)
#plataformas_generadas[nueva_posicion_redondeada] = nueva_plataforma
#ultima_posicion_generada = nueva_posicion_redondeada
