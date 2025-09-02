extends StaticBody3D

@export var SPEED: float = 1

func _ready():
	pass
	
func _process(delta):
	position.x -= SPEED
