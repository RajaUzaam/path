extends StaticBody3D

@export var pillar_scene: PackedScene
@export var railing_scene: PackedScene
@export var pillar_spacing: int = 5
@export var path: Node3D
var current_position
func _ready():
	current_position = Vector3(-pillar_spacing, 0, 0)
	for x in range(9):
		addRailing(x)
	for i in range(int(150/pillar_spacing)):
		addPillar(true)

func addRailing(n: int) -> void:
	#x**2 + y**2 = r**2
	#x = (r**2 - y**2)**0.5
	const r: float = 6
	var y: float = 6-(1.5*n)
	var z: float = ((r**2) - (y**2))**0.5
	for i in range(2):
		var railing = railing_scene.instantiate()
		add_child(railing)
		railing.position = Vector3(0, y, z*(i*-1))

func addPillar(gen: bool) -> void:
	if gen:
		current_position.x += pillar_spacing
	var pillar = pillar_scene.instantiate()
	add_child(pillar)
	pillar.position = Vector3(current_position.x, current_position.y, current_position.z)
