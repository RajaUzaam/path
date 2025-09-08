extends Control

@onready var main_menu = $MainMenu
@onready var root_ui: RootUI = get_parent() as RootUI

func _ready() -> void:
	%StartBtn.pressed.connect(func(): UIChange("GAME_UI"))
	%InstructionsBtn.pressed.connect(func(): UIChange("INSTRUCTIONS"))
	%SettingsBtn.pressed.connect(func(): UIChange("SETTINGS"))
	%Score.text = "Highscore: " + str(PD.high_score)
	%Highscore.text = "Time: " + str(PD.high_stopwatch_time)

func UIChange(scene_name: String) -> void:
	if root_ui == null: return
	if scene_name == "GAME_UI":
		root_ui.GameStarted()
		return
	root_ui.ChangeUISceneTo(scene_name)
