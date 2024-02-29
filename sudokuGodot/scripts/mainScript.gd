extends Node2D

var row = 9
var col = 9
var size = 40
var Panel_scene= preload("res://Panel.tscn")
var arr = []

func _ready():
	init_grids()
	init_arr()
	fill_numbers()
	clean_numbers()
	show()

func init_grids():	
	var offset_x =0
	var offset_y =0
	for i in row:
		offset_x = 0
		offset_y += 2
		if i  %3 ==0:
			offset_y += 2
		for j in col:
			offset_x +=2
			if j  %3 ==0:
				offset_x += 2
			var panel = Panel_scene.instance()
			panel.rect_position=Vector2(size*j,size*i) + Vector2(offset_x, offset_y)
			add_child(panel)

func init_arr():
	for i in row:
		for j in col:
			arr.append(null)

func show():
	var panels = get_children()
	for i in row:
		for j in col:
			var number = arr[i * row + j]
			if number:
				panels[i * row + j].get_node("Label").text = str(number)

func fill_numbers():
	for n in 3:
		var tmp = [1, 2, 3, 4, 5, 6, 7, 8, 9]
		tmp.shuffle()
		for i in range(n * 3, n * 3 + 3):
				for j in range(n * 3, n * 3 + 3):
					arr[i * row + j] = tmp.pop_back()
	fill_empty()

func fill_empty():
		var find_null = arr.find(null)
		if find_null ==-1:
			return true
	
		var i = find_null / row
		var j = find_null % col
		
		var candidates = get_candidates(i,j)
		if !candidates:
			return false
		
		var fill
		while candidates:
			fill = candidates.pop_back()
			arr[i * row +j] = fill
			if fill_empty():
				return true
			else:
				arr[i * row + j] = null

func get_candidates(i,j):
	var tmp = [1,2,3,4,5,6,7,8,9]
	for number in get_row_numbers(i):
		tmp.erase(number)
	for number in get_col_numbers(j):
		tmp.erase(number)
	for number in get_area_numbers(i,j):
		tmp.erase(number)
	return tmp

func get_row_numbers(i):
	var res = []
	for j in col:
		var number = arr[i * row +j]
		if number:
			res.append(number)
	return res

func get_col_numbers(j):
	var res = []
	for i in row:
		var number = arr[i * row +j]
		if number:
			res.append(number)
	return res

func get_area_numbers(i,j):

	var offset_i = i / 3 * 3
	var offset_j = j / 3 * 3
	var res = []
	for area_i in range(offset_i, offset_i+3):
		for area_j in range(offset_j, offset_j +3):
			var number = arr[area_i * row + area_j]
			if number:
				res.append(number)
	return res



func clean_numbers():
	for i in row:
		for j in col:
			var candidates = get_candidates(i,j)
			if candidates.empty():
				arr[i * row +j] = null
