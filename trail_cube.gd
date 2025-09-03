extends MeshInstance3D

func _process(delta):
	position.x -= GV.game_speed
	if position.x <= -10:
		queue_free()
