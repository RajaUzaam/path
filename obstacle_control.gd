extends Node3D
class_name ObstacleControl

func onCollision() -> void:
	onDeath()
	
func onDeath() -> void:
	print('You Died!')
