extends Node3D

var obstacle_list = [
	"res://both_obstacle.tscn", 
	"res://jump_obstacle.tscn", 
	"res://normal_obstacle.tscn", 
	"res://roll_obstacle.tscn"
	]
var obstacle


func _ready():
	var randNum = randi_range(0, 4)-1
	var obstacle_path = str(obstacle_list[randNum])
	obstacle = load(obstacle_path).instantiate()
	add_child(obstacle)
	obstacle.body_entered.connect(_on_obstacle_body_entered)

func setColor(color: Color):
	var newColor = ColorControl.new().get_triadic_colors(color)[2]
	for i in obstacle.get_children():
		if i.has_meta('Mesh'):
			ColorControl.new().setColor(newColor, i)

func _on_obstacle_body_entered(body):
	if body.name == 'Player':
		ObstacleControl.new().onCollision()
