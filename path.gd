extends Node3D

@export var cube_scene: PackedScene
@export var number_of_cubes: int = 50
@export var x_step_size: float = 2
@export var z_step_size: float = 1
#@export var bump_corr_freq: int = 3
@export var start_x: float = -10
@export var plane: MeshInstance3D
#@export var jump_obstacle_scene: PackedScene
#var bump_flag: int = 0
#var corr_count = 0
#@export var player: CharacterBody3D
var tile_rgb: ColorChanger
var current_position
var tile_num: int = 0

func _ready() -> void:
	tile_rgb = ColorChanger.new(Color(0, 1, 0), "b", 1, 0.025)
	
	current_position = Vector3(6, 0, 0)
	randomize()

	for i in range(number_of_cubes):
		addCube(true)
	current_position.x += start_x-6


func addCube(gen: bool) -> void:
	var cube = cube_scene.instantiate()
	add_child(cube)
	tile_rgb.cycle()
	cube.position = current_position
	#cube.setColor(tile_rgb.get_color())
	if gen:
		cube.setCube(tile_rgb.get_color(), tile_num, false)
		current_position.x += x_step_size
	else:
		tile_num += 1
		current_position = newRandPos(current_position)
		cube.setCube(tile_rgb.get_color(), tile_num, true)
		#if tile_num%4 == 0:
			#cube.addObstacle()
			#var jump_obstacle = jump_obstacle_scene.instantiate()
			#cube.add_child(jump_obstacle)
			#jump_obstacle.scale = 0.75

func newRandPos(currPos) -> Vector3:
	var randPos = currPos
	var randz = randi_range(1, 2)
	#if bump_flag != 0:
		#randPos = fixBump(randPos)
		#return randPos
	#if currPos.z >= plane.scale.z-1:
		#bump_flag = 1
	#elif currPos.z <= -plane.scale.z+1:
		#bump_flag = -1
	#else:
	match randz:
		1: randPos.z += z_step_size
		2: randPos.z -= z_step_size
	return randPos

#func fixBump(currPos):
	#if bump_flag == 1:
		#currPos.z -= 1
	#elif bump_flag == -1:
		#currPos.z += 1
	#if corr_count >= bump_corr_freq:
		#bump_flag = 0
		#corr_count = 0
	#corr_count += 1
	#return currPos
