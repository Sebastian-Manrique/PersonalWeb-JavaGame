extends Node2D

var row = 9
var col = 9
var size = 40
var Panel_scene= preload("res://Panel.tscn")
var arr = []

func _ready():
	init_grids()
	init_arr()
	arr[0] = 1
	arr[10] = 1
	arr[20] = 1
	arr[30] = 1
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