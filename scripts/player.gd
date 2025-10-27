extends CharacterBody3D

@export var JUMP_VELOCITY: float = 3.75
@export var trailCube: PackedScene
@export var trail: Node3D
@onready var mesh: MeshInstance3D = $MeshInstances/cubeMesh
@export var path: Node3D
@onready var cube: Node3D = $cube
var mouse_captured: bool = false
var cube_color: Color
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	#GV.game_speed = 0.05
	$cube.scale = Vector3(0.5, 0.5, 0.5)
	$cube.position = Vector3.ZERO
	$CollisionShape3D.scale = Vector3(1, 1, 1)
	$CollisionShape3D.position = Vector3.ZERO

func _physics_process(delta) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
		
	#changeColor()
	checkBoundary()
	
	if !mouse_captured:
		return
	
	if Input.is_action_just_pressed("jump") and is_on_floor() and !animation_player.is_playing():
		animation_player.play("jump")
		velocity.y = JUMP_VELOCITY
	
	#var mouse_pos = get_viewport().get_mouse_position()
	#var screen_width = get_viewport().size.x
	#
	#var offset_scale = 0.01
	#var offset = (mouse_pos.x - screen_width / 2.0) * offset_scale
#
	#var pos = global_position
	#pos.z = offset
	#global_position = pos

	move_and_slide()

func changeColor() -> void:
	var mat: StandardMaterial3D = cube.get_child(0).get_active_material(0)
	var tile_color: Color = path.tile_rgb.get_color()
	cube_color = ColorControl.new().get_complementary_color(tile_color)
	mat.albedo_color = cube_color


func addTrail() -> void:
	var trail_cube = trailCube.instantiate()
	trail.add_child(trail_cube)
	trail_cube.position = Vector3(position.x, position.y-(scale.x/2), position.z)
	var trail_color = ColorControl.new().get_triadic_colors(mesh.get_active_material(0).albedo_color)[2]
	trail_cube.setColor(trail_color)
	trail_cube.scale = self.scale/2
	
@onready var boost: AudioStreamPlayer3D = $boost
var mouse_sensitivity: float = 0.01

func _input(event) -> void:
	if !GV.game_started: return
	if event is InputEventMouseMotion:
		var delta_x = event.relative.x
		global_position.z += delta_x * mouse_sensitivity
	if event.is_action_pressed("roll"):
		boost.play()
		$Timer.start()
		GV.game_speed = 0.1
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		mouse_captured = true
	elif event.as_text() == "Tab":
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		mouse_captured = false

func checkBoundary() -> void:
	if position.y <= -2.5:
		get_tree().root.get_node("Main").get_node("UI").OnDeath()


func _on_timer_timeout() -> void:
	GV.game_speed = 0.05
