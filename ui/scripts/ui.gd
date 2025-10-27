extends CanvasLayer
class_name RootUI

const UI_PACKED_SCENES: Dictionary[String, String] = {
	'MAIN_MENU': "res://ui/scenes/main_menu.tscn",
	'GAME_UI': "res://ui/scenes/game_ui.tscn",
	'SETTINGS': "res://ui/scenes/settings.tscn",
	'INSTRUCTIONS': "res://ui/scenes/instructions.tscn",
	'PAUSE_MENU': "res://ui/scenes/pause_menu.tscn",
	'OVER_SCREEN': "res://ui/scenes/over_screen.tscn"
}

var prev_ui_scene: Control
var curr_ui_scene: Control
var main_menu: Control

func _ready() -> void:
	ChangeUISceneTo("MAIN_MENU")

func OnDeath() -> void:
	get_tree().paused = true
	DataHandler.new().StatsSave()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	GV.game_ended = true
	ChangeUISceneTo("OVER_SCREEN")

func GameStarted() -> void:
	GV.game_started = true
	ChangeUISceneTo("GAME_UI")

func PerformRestart() -> void:
	PD.score = 0
	PD.stopwatch_time = 0
	GV.game_started = false
	GV.game_ended = false
	DataHandler.new().Load()
	get_tree().paused = false
	get_tree().reload_current_scene()

func ChangeGameState() -> void:
	if !GV.game_started or GV.game_ended: return
	get_tree().paused = !get_tree().paused
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if get_tree().paused else Input.MOUSE_MODE_HIDDEN
	ChangeUISceneTo("PAUSE_MENU" if get_tree().paused else "GAME_UI")

func ChangeUISceneTo(scene_name: String) -> void:
	if curr_ui_scene != null: curr_ui_scene.queue_free()
	curr_ui_scene = load(UI_PACKED_SCENES[scene_name]).instantiate()
	add_child(curr_ui_scene)

func _input(event) -> void:
	if event.is_action_pressed("pause"):
		ChangeGameState()
