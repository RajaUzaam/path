extends Node3D

@export var cube_scene: PackedScene
@export var number_of_cubes: int = 50
@export var x_step_size: float = 2
@export var z_step_size: float = 1
@export var start_x: float = -10
@export var plane: MeshInstance3D
var tile_rgb: ColorChanger
var current_position
var tile_num: int = 0
const START_X_POS: float = 2

func _ready() -> void:
	tile_rgb = ColorChanger.new(Color(0, 1, 0), "b", 1, 0.025)
	
	current_position = Vector3(START_X_POS, 0, 0)
	randomize()

	for i in range(number_of_cubes):
		addCube(true)
	current_position.x += start_x-START_X_POS


func addCube(gen: bool) -> void:
	var cube = cube_scene.instantiate()
	add_child(cube)
	tile_rgb.cycle()
	cube.position = current_position
	if gen:
		cube.setCube(tile_rgb.get_color(), tile_num, false)
		current_position.x += x_step_size
	else:
		tile_num += 1
		current_position = newRandPos(current_position)
		cube.setCube(tile_rgb.get_color(), tile_num, true)

func newRandPos(currPos) -> Vector3:
	if !GV.game_started: return currPos
	var randPos = currPos
	var randz = randi_range(1, 2)
	match randz:
		1: randPos.z += z_step_size
		2: randPos.z -= z_step_size
	return randPos
