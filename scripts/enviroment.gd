extends Node3D

@export var player: CharacterBody3D

func _ready() -> void:
	for i in range(8):
		for j in range(5):
			var cloud: Node3D = load("res://assests/world/Clouds/cloud.tscn").instantiate()
			add_child((cloud))
			cloud.randomize_transform(i, j)
	var start_pos: Vector3 = Vector3(100, -20, -150)
	for i in range(200):
		var platform: Node3D = load("res://assests/world/horizon_mountains.tscn").instantiate()
		add_child(platform)
		platform.position = start_pos
		platform.position.z = (i*2) + start_pos.z + randi_range(-4, 2)
		platform.scale = Vector3(10, 10, 10) * randf_range(1, 1.5)

func _physics_process(_delta: float) -> void:
	position.z = player.position.z
