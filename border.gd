extends StaticBody3D

@export var pillar_scene: PackedScene
@export var pillar_spacing: int = 5
var current_position
func _ready():
	current_position = Vector3(-pillar_spacing, 0, 0)
	for i in range(int(150/pillar_spacing)):
		addPillar(true)


func addPillar(gen: bool):
	if gen:
		current_position.x += pillar_spacing
	var pillar = pillar_scene.instantiate()
	add_child(pillar)
	pillar.position = Vector3(current_position.x, current_position.y, current_position.z)
