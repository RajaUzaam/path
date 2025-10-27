extends Node3D

@onready var ship: Node3D = $Ship
var startSailingShip = false
func _ready() -> void:
	ship.visible = false
	ship.position.x = 75
	ship.position.z = 200
	ship.position.y = -15
	$Timer.start()

func _process(_delta: float) -> void:
	if startSailingShip:
		ship.position.z -= 0.075
		if ship.position.z <= -200:
			ship.visible = false
			startSailingShip = false
			ship.position.z = 100
			$Timer.start()

func _on_timer_timeout() -> void:
	ship.visible = true
	startSailingShip = true
