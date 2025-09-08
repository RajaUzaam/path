extends Control

var root_ui: RootUI

func _ready():
	root_ui = get_parent()
	if root_ui == null: return
	%Score.text = "Score: " + str(PD.score)
	%Time.text = "Time: " + str(PD.stopwatch_time)
	%MainMenuBtn.pressed.connect(func(): root_ui.PerformRestart())
