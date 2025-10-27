extends Control

@onready var root_ui: RootUI = get_parent() as RootUI
var eligible_to_start: bool = true

func _ready() -> void:
	#%StatisticsBtn.mouse_entered.connect(func(): eligible_to_start = false)
	#%StatisticsBtn.mouse_exited.connect(func(): eligible_to_start = true)
	#%StatisticsBtn.pressed.connect(func(): UIChange("INSTRUCTIONS"))
	#%InstructionsBtn.mouse_entered.connect(func(): eligible_to_start = false)
	#%InstructionsBtn.mouse_exited.connect(func(): eligible_to_start = true)
	#%InstructionsBtn.pressed.connect(func(): UIChange("INSTRUCTIONS"))
	%SettingsBtn.mouse_entered.connect(func(): eligible_to_start = false)
	%SettingsBtn.mouse_exited.connect(func(): eligible_to_start = true)
	%SettingsBtn.pressed.connect(func(): UIChange("SETTINGS"))
	%Score.text = str(PD.high_score) + " | " + str(PD.high_stopwatch_time)
	%Stars.text = str(PD.stars)
	
func _input(event):
	if event.as_text() == "Left Mouse Button" and eligible_to_start:
		UIChange("GAME_UI")

func UIChange(scene_name: String) -> void:
	if root_ui == null: return
	if scene_name == "GAME_UI":
		root_ui.GameStarted()
		return
	root_ui.ChangeUISceneTo(scene_name)
