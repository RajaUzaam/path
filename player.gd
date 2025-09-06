extends CharacterBody3D


@export var SPEED: float = 5.0
@export var JUMP_VELOCITY: float = 4.5
@export var trailCube: PackedScene
@export var trail: Node3D
@onready var mesh: MeshInstance3D = $MeshInstances/cubeMesh
@export var path: Node3D
@onready var cube: Node3D = $cube
var mouse_captured: bool = false
var cube_color: Color
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	$cube.scale = Vector3(0.5, 0.5, 0.5)
	$cube.position = Vector3.ZERO
	$CollisionShape3D.scale = Vector3(1, 1, 1)
	$CollisionShape3D.position = Vector3.ZERO

#func _physics_process(delta):
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	#var input_dir = -int(Input.is_action_pressed("left")) + int(Input.is_action_pressed("right"))
	#if input_dir != 0:
		#velocity.z = input_dir * SPEED
	#else:
		#velocity.z = move_toward(velocity.z, 0, SPEED)
#
	#move_and_slide()

func _physics_process(delta) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	changeColor()
	addTrail()
	checkBoundary()
	
	if !mouse_captured:
		return
		
	if Input.is_action_just_pressed("jump") and is_on_floor() and !animation_player.is_playing():
		animation_player.play("jump")
		velocity.y = JUMP_VELOCITY
	
	var mouse_pos = get_viewport().get_mouse_position()
	var screen_width = get_viewport().size.x
	
	var offset_scale = 0.01
	var offset = (mouse_pos.x - screen_width / 2.0) * offset_scale

	var pos = global_position
	pos.z = offset
	global_position = pos

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

func _input(event) -> void:
	if event.is_action_pressed("roll") and !animation_player.is_playing():
		animation_player.play("roll")
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		mouse_captured = true
	elif event.as_text() == "Tab":
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		mouse_captured = false

func checkBoundary() -> void:
	if position.y <= -2.5:
		ObstacleControl.new().onCollision()
		get_tree().paused = true # LATER TO BE CHANGED
