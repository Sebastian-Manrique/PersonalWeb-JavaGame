extends CharacterBody2D

var can_move = true
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

@onready var animation_player = $AnimationPlayer


func _ready():
	AudioPlayer.poner_la_musica_nivel()


func redondear_posicion(pos: Vector2) -> Vector2:
	return Vector2(round(pos.x / TOLERANCIA_POSICION) * TOLERANCIA_POSICION, round(pos.y / TOLERANCIA_POSICION) * TOLERANCIA_POSICION)


func _physics_process(delta: float) -> void:
	if not can_move:
		return

	if is_on_floor():
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

	if not is_on_floor() and ya_pisada:
		ya_pisada = false

	if Input.is_action_just_pressed("ui_accept") and puede_saltar:
		velocity.y = JUMP_VELOCITY
		puede_saltar = false  # Evita que se siga saltando después del tiempo de coyote

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if direction > 0:
			animation_player.play("move_right")
		else:
			animation_player.play("move_left")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.x == 0:
			animation_player.play("idle")

	move_and_slide()


func disable_movement():
	can_move = false
	animation_player.stop()
