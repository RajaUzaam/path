extends CharacterBody3D


@export var SPEED: float = 5.0
@export var JUMP_VELOCITY: float = 4.5
@export var trailCube: PackedScene
@export var trail: Node3D
@onready var mesh: MeshInstance3D = $MeshInstances/cubeMesh
@export var path: Node3D
var mouse_captured = false
var cube_color: Color


#func _ready():
	#cube_color = ColorControl.new(Color(1, 0, 0), 'g', 1, 0.001)

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

func _physics_process(delta):
	#print(path.tile_rgb)
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	changeColor()
	addTrail()
	
	if !mouse_captured:
		return
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var mouse_pos = get_viewport().get_mouse_position()
	var screen_width = get_viewport().size.x
	
	var scale = 0.01
	var offset = (mouse_pos.x - screen_width / 2.0) * scale

	var pos = global_position
	pos.z = offset
	global_position = pos

	move_and_slide()

func changeColor():
	var mat := mesh.get_active_material(0)
	var tile_color: Color = path.tile_rgb.get_color()
	cube_color = Color(tile_color.g, tile_color.b, tile_color.r)
	mat.albedo_color = cube_color

func addTrail():
	var cube = trailCube.instantiate()
	trail.add_child(cube)
	cube.position = Vector3(position.x, 0.002, position.z)
	cube.scale = self.scale/2

func _input(event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		mouse_captured = true
	elif event.as_text() == "Tab":
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		mouse_captured = false
