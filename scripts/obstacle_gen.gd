extends Node3D

var obstacle_list: Array[String] = [
	"res://scenes/obstacles/both_obstacle.tscn", 
	"res://scenes/obstacles/jump_obstacle.tscn", 
	"res://scenes/obstacles/normal_obstacle.tscn", 
	"res://scenes/obstacles/roll_obstacle.tscn"
	]
var obstacle: Area3D


func _ready() -> void:
	var randNum: int = randi_range(0, len(obstacle_list))-1
	var obstacle_path: String = str(obstacle_list[randNum])
	obstacle = load(obstacle_path).instantiate()
	add_child(obstacle)
	obstacle.body_entered.connect(_on_obstacle_body_entered)

func setColor(color: Color) -> void:
	var newColor: Color = ColorControl.new().get_triadic_colors(color)[2]
	for i in obstacle.get_children():
		if i.has_meta('Mesh'):
			ColorControl.new().setColor(newColor, i)

func _on_obstacle_body_entered(body) -> void:
	if body.name == 'Player':
		get_tree().root.get_node("Main").get_node("UI").OnDeath()
