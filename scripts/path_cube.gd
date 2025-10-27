extends StaticBody3D

@onready var plane_path: MeshInstance3D = $pathObj/planePath
@onready var animation_player = $AnimationPlayer

var curr_anim = 'height_anim'
@onready var path_obj = $pathObj
const SCORE = preload("res://scenes/score.tscn")
const OBSTACLE_GEN = preload("res://scenes/obstacle_gen.tscn")

func _ready():
	visible = false

func setCube(color: Color, cube_idx: int, gen_obstacle: bool = false) -> void:
	#setColor(color)
	addObstacle(color, cube_idx, gen_obstacle)

func setColor(color: Color) -> void:
	ColorControl.new().setColor(color, plane_path)

func addObstacle(color: Color, idx: int, gen: bool) -> void:
	if !GV.game_started: return
	if (idx%4 != 0) or (!gen):
		var score_scene = SCORE.instantiate()
		path_obj.add_child(score_scene)
		score_scene.position = Vector3(0, 0.5, 0)
		score_scene.scale = Vector3(0.4375, 0.4375, 0.4375)
		return
	var obstacle_scene = OBSTACLE_GEN.instantiate()
	path_obj.add_child(obstacle_scene)
	obstacle_scene.scale = Vector3(0.875, 0.875, 0.875)
	#obstacle_scene.setColor(color)
	return

func _process(_delta):
	position.x -= GV.game_speed
	if position.x <= 8 and !animation_player.is_playing():
		animation_player.play(curr_anim)
	if position.x <= -10:
		get_parent().addCube(false)
		queue_free()

func _on_animation_player_animation_finished(_anim_name):
	curr_anim = 'default'
