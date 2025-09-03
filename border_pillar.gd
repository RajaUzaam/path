extends MeshInstance3D


func _process(delta):
	position.x -= GV.game_speed
	if position.x <= -get_parent().pillar_spacing:
		get_parent().addPillar(false)
		queue_free()
