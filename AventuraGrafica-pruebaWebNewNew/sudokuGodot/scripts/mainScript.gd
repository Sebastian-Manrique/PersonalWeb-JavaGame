extends Node2D

var row = 9
var col = 9
var size = 40
var Panel_scene = preload("res://Panel.tscn")
var arr = []
var green_color = Color(0, 1, 0)  # Color verde
var red_color = Color(1, 0, 0)  # Color rojo
var black_color = Color(0, 0, 0)  # Color negro
var current_edit_row = -1
var current_edit_col = -1
var text_edit_connection  # Variable para almacenar la conexión de la señal
var all_numbers_set = false

func _ready():
	init_grids()
	init_arr()
	fill_numbers()
	clean_numbers()
	show()
	text_edit_connection = $Control/TextEdit.connect("text_changed", self, "_on_text_entered")

func _on_text_entered():
	var edit = $Control/TextEdit
	var row_idx = int(float(edit.get_index()) / row)
	var col_idx = int(edit.get_index() % col)
	var number = int(edit.text)
	print("Número introducido:", number)  # Imprimir el número introducido por el usuario
	if number >= 1 && number <= 9:
		arr[row_idx * row + col_idx] = number
		var is_valid = is_row_valid(row_idx) && is_col_valid(col_idx) && is_area_valid(row_idx, col_idx)
		if is_valid:
			edit.add_color_override("font_color", green_color)
			check_row_and_col(row_idx, col_idx, number)
		else:
			edit.add_color_override("font_color", red_color)
	else:
		edit.add_color_override("font_color", Color(1, 1, 1))  # Restaurar el color predeterminado

	# Verificar si todos los números han sido ingresados
	if !arr.has(null):
		all_numbers_set = true
		disable_read_only()

func disable_read_only():
	var panels = get_children()
	for panel in panels:
		var text_edit = panel.get_node("TextEdit")
		text_edit.read_only = false
		text_edit.add_color_override("custom_background_color", black_color)

func init_grids():
	var offset_x = 0
	var offset_y = 0
	for i in range(row):
		offset_x = 0
		offset_y += 2
		if i % 3 == 0:
			offset_y += 2
		for j in range(col):
			offset_x += 2
			if j % 3 == 0:
				offset_x += 2
			var panel = Panel_scene.instance()
			panel.rect_position = Vector2(size * j, size * i) + Vector2(offset_x, offset_y)
			add_child(panel)

func init_arr():
	for i in range(row):
		for j in range(col):
			arr.append(null)

func show():
	var panels = get_children()
	for i in range(row):
		for j in range(col):
			var number = arr[i * row + j]
			var panel = panels[i * row + j]
			var text_edit = panel.get_node("TextEdit")
			if number:
				text_edit.text = str(number)
				text_edit.read_only = true
				text_edit.add_color_override("custom_background_color", black_color)
			else:
				text_edit.text = ""
				text_edit.read_only = false
				text_edit.add_color_override("custom_background_color", Color(1, 1, 1))  # Restaurar el color predeterminado

func fill_numbers():
	for n in range(3):
		for i in range(n * 3, n * 3 + 3):
			for j in range(n * 3, n * 3 + 3):
				arr[i * row + j] = (i * 3 + j + 1) % 9 + 1  # Llenar de 1 a 9 en cada bloque de 3x3
	fill_empty()

func fill_empty():
	var find_null = arr.find(null)
	if find_null == -1:
		return true

	var i = find_null / row
	var j = find_null % col

	var candidates = get_candidates(i, j)
	if !candidates:
		return false

	var fill
	while candidates:
		fill = candidates.pop_back()
		arr[i * row + j] = fill
		if fill_empty():
			return true
		else:
			arr[i * row + j] = null

	if is_row_complete(i) or is_col_complete(j):
		print("Row or column is complete!")  # Aquí puedes agregar la lógica que desees al completar una fila o columna.

func get_candidates(i, j):
	var tmp = [1, 2, 3, 4, 5, 6, 7, 8, 9]
	for number in get_row_numbers(i):
		tmp.erase(number)
	for number in get_col_numbers(j):
		tmp.erase(number)
	for number in get_area_numbers(i, j):
		tmp.erase(number)
	return tmp

func get_row_numbers(i):
	var res = []
	for j in range(col):
		var number = arr[i * row + j]
		if number:
			res.append(number)
	return res

func get_col_numbers(j):
	var res = []
	for i in range(row):
		var number = arr[i * row + j]
		if number:
			res.append(number)
	return res

func get_area_numbers(i, j):
	var offset_i = i / 3 * 3
	var offset_j = j / 3 * 3
	var res = []
	for area_i in range(offset_i, offset_i + 3):
		for area_j in range(offset_j, offset_j + 3):
			var number = arr[area_i * row + area_j]
			if number:
				res.append(number)
	return res

func clean_numbers():
	for i in range(row):
		for j in range(col):
			var candidates = get_candidates(i, j)
			if candidates.empty():
				arr[i * row + j] = null

func is_row_complete(i):
	var numbers_in_row = get_row_numbers(i)
	return numbers_in_row.size() == 9

func is_col_complete(j):
	var numbers_in_col = get_col_numbers(j)
	return numbers_in_col.size() == 9

func is_row_valid(i):
	var numbers_in_row = get_row_numbers(i)
	return numbers_in_row.size() == len(numbers_in_row.unique())

func is_col_valid(j):
	var numbers_in_col = get_col_numbers(j)
	return numbers_in_col.size() == len(numbers_in_col.unique())

func is_area_valid(i, j):
	var numbers_in_area = get_area_numbers(i, j)
	return numbers_in_area.size() == len(numbers_in_area.unique())

func check_row_and_col(row_idx, col_idx, number):
	var row_numbers = get_row_numbers(row_idx)
	var col_numbers = get_col_numbers(col_idx)
	if number in row_numbers and number in col_numbers:
		print("El número", number, "está correctamente introducido en la fila y columna.")
	else:
		print("El número", number, "no está correctamente introducido en la fila y columna.")
