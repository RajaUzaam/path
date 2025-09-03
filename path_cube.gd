extends Area3D

@onready var plane_path: MeshInstance3D = $planePath

func setColor(color: Color):
	var mat := plane_path.get_active_material(0) # safer than surface_get_material
	mat.albedo_color = color

func _process(delta):
	position.x -= GV.game_speed
	if position.x <= -10:
		get_parent().addCube(false)
		queue_free()

#func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	#pass
#
#
#func _on_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	#print("Death!")


#func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	#print(body.name)
