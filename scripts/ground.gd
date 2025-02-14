extends StaticBody2D

@export var ground_scene: PackedScene  # Escena del suelo a generar
@export var personaje: Node2D  # Referencia al jugador
@export var detection_radius: float = 200.0  # Radio de detección
@export var ground_offset: float = 64.0  # Distancia entre suelos

var generated_positions = []  # Lista para evitar generar suelo duplicado


func _process(delta):
	if personaje:
		print("Generando suelo")
		var distance = global_position.distance_to(personaje.global_position)
		if distance < detection_radius:
			generate_ground_nearby()


func generate_ground_nearby():
	var directions = [Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN]
	for dir in directions:
		var new_position = global_position + (dir * ground_offset)
		if new_position not in generated_positions:
			var new_ground = ground_scene.instantiate()
			new_ground.global_position = new_position
			get_parent().add_child(new_ground)
			generated_positions.append(new_position)
