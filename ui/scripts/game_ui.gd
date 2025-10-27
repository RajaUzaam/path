extends Control

@onready var timer: Timer = $Timer

func _ready():
	%PauseBtn.pressed.connect(func(): get_parent().ChangeGameState())

func _process(_delta):
	%Score.text = str(PD.score) + " | " + str(PD.stopwatch_time)

func _on_timer_timeout():
	PD.stopwatch_time += 1
