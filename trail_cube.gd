extends MeshInstance3D

func setColor(color: Color) -> void:
	color.a = 0.5
	ColorControl.new().setColor(color, self)

func _process(delta):
	position.x -= GV.game_speed
	if position.x <= -10:
		queue_free()
