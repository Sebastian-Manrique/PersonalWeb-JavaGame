extends Label

var contador = 0
var metros = 0
@onready var label = $"."
@onready var personaje = $".."


func _ready():
	actualizar_label()
	var timer = Timer.new()
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


func actualizar_label():
	label.text = "Contador: " + str(contador) + "\n " + str(metros) + " m"
