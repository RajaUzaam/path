extends Area3D



func _on_body_entered(body):
	if body.name == 'Player':
		GV.score += 1
		print('Score: ', GV.score)
		queue_free()
