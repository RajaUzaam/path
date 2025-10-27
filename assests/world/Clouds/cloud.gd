extends Node3D

var start_pos: Vector3 = Vector3(0, -27, -100)
var col;

func randomize_transform(i, j):
	col = j
	position.y = start_pos.y + randi_range(-6, 4)
	position.z = (j*50) + start_pos.z + randi_range(-5, 5)
	position.x = (i*50) + start_pos.x + randi_range(-5, 5)
	rotate_y(randf_range(0,  2*PI))
	scale = Vector3(50, 50, 50)

func _process(_delta: float) -> void:
	position.x -= GV.game_speed
	if position.x <= -50:
		randomize_transform(8, col)
		position.x -= 50
