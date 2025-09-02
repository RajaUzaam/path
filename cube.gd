extends Node3D


func _process(delta):
	position.x -= 0.125
	if position.x < -10:
		get_parent().addCube(false)
		queue_free()
