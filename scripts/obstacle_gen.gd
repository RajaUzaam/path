extends Node3D

var obstacle_list: Array[String] = [
	"res://scenes/obstacles/Scenes/Fence Type1 01.tscn",
	"res://scenes/obstacles/Scenes/Fence Type1 02.tscn",
	"res://scenes/obstacles/Scenes/Fence Type2 01.tscn",
	"res://scenes/obstacles/Scenes/Fence Type2 02.tscn",
	"res://scenes/obstacles/Scenes/Fence Type3 01.tscn",
	"res://scenes/obstacles/Scenes/Fence Type3 02.tscn"
	
	]

func _ready() -> void:
	var randNum: int = randi_range(0, len(obstacle_list))-1
	var obstacle_path: String = str(obstacle_list[randNum])
	var mesh = load(obstacle_path).instantiate()
	mesh.scale = Vector3(0.75, 0.75, 0.75)
	mesh.position.z = -0.75
	mesh.rotate_x(-PI/2)
	mesh.rotate_y(-PI/2)
	add_child(mesh)

func _on_obstacle_body_entered(body) -> void:
	if body.name == 'Player':
		get_tree().root.get_node("Main").get_node("UI").OnDeath()
