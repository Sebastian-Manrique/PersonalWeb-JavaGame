extends TextEdit

var num = "1"
func _ready():
	set_text(num)
	var player_input = get_text()
	print("Texto inicial:", player_input)

	
func _on_TextEdit_text_changed():
	var player_input = get_text()
	print("Texto cambiado:", player_input)
	if player_input == num:
		print("Bien hecho")
	else:
		print("Mal hecho")

