extends Node3D

@export var cube_scene: PackedScene
@export var number_of_cubes: int = 50
@export var x_step_size: float = 0.5
@export var z_step_size: float = 1
@export var bump_corr_freq: int = 5
@export var start_x: float = 0
@export var plane: MeshInstance3D
var bump_flag: int = 0
var corr_count = 0
var current_position
@export var tile_rgb: ColorControl


func _ready():
	tile_rgb = ColorControl.new(Color(0, 1, 0), "b", 1, 0.02)
	
	current_position = Vector3(start_x, 0.001, 0)
	randomize()

	for i in range(number_of_cubes):
		addCube(true)
func addCube(gen: bool):
	var cube = cube_scene.instantiate()
	add_child(cube)
	current_position = newRandPos(current_position)
	tile_rgb.cycle()
	cube.position = current_position
	cube.setColor(tile_rgb.get_color())
	if gen:
		current_position.x += x_step_size

func newRandPos(currPos):
	var randPos = currPos
	var randz = randi_range(1, 2)
	if bump_flag != 0:
		randPos = fixBump(randPos)
		return randPos
	if currPos.z >= plane.scale.z-1:
		bump_flag = 1
	elif currPos.z <= -plane.scale.z+1:
		bump_flag = -1
	else:
		match randz:
			1: randPos.z += z_step_size
			2: randPos.z -= z_step_size
	return randPos

func fixBump(currPos):
	if bump_flag == 1:
		currPos.z -= 1
	elif bump_flag == -1:
		currPos.z += 1
	if corr_count >= bump_corr_freq:
		bump_flag = 0
		corr_count = 0
	corr_count += 1
	return currPos
