extends StaticBody3D

@onready var plane_path: MeshInstance3D = $planePath
@onready var animation_player = $AnimationPlayer

var curr_anim = 'height_anim'

#func _ready():
	#visible = false

func setColor(color: Color):
	ColorControl.new().setColor(color, plane_path)

func _process(delta):
	position.x -= GV.game_speed
	if position.x <= 7 and !animation_player.is_playing():
		animation_player.play(curr_anim)
	if position.x <= -10:
		get_parent().addCube(false)
		queue_free()


func _on_animation_player_animation_finished(anim_name):
	curr_anim = 'default'


#func _on_animation_player_animation_started(anim_name):
	#visible = true
	#print(visible)
