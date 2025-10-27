extends Control

var ui_root: RootUI

func _ready():
	ui_root = get_parent()
	%ResumeBtn.pressed.connect(func(): ui_root.ChangeGameState())
	%MainMenuBtn.pressed.connect(func(): ui_root.PerformRestart())
	%Score.text = str(PD.score) + " | " + str(PD.stopwatch_time)
