extends Control

var root_ui: RootUI

func _ready():
	root_ui = get_parent()
	%Goback.pressed.connect(func(): root_ui.ChangeUISceneTo("MAIN_MENU"))
