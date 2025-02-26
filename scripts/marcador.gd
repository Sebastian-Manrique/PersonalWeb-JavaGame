extends Label

var contador = 0
var metros = 0
@onready var label = $"."
@onready var personaje = $".."
@onready var ganaste_label = $"../ganaste"
@onready var perdiste_label = $"../perdiste"
@onready var cerrar_juego = $"../cerrarJuego"
var timer


func _ready():
	actualizar_label()
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.0
	timer.timeout.connect(_on_timer_timeout)
	timer.start()


func _on_timer_timeout():
	contador += 1
	metros = personaje.position.y
	metros = abs(metros)
	metros = round(metros - 16)
	actualizar_label()
	if contador >= 1:
		mostrar_perdiste()
	if metros >= 2000:
		mostrar_ganaste()


func actualizar_label():
	label.text = str(contador) + " s\n" + str(metros) + " m"


func mostrar_perdiste():
	personaje.disable_movement()
	perdiste_label.visible = true
	cerrar_juego.visible = true
	timer.stop()  # Detener el temporizador


func mostrar_ganaste():
	personaje.disable_movement()
	ganaste_label.visible = true
	cerrar_juego.visible = true
	timer.stop()  # Detener el temporizador


func _on_cerrar_juego_pressed() -> void:
	get_tree().quit()  # Cierro el juego, facilito
