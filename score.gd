extends Area3D



func _on_body_entered(body):
	if body.name == 'Player':
		PD.score += 1
		print('Score: ', PD.score)
		queue_free()
