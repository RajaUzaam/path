extends Node
class_name ColorControl

var start_color: Color = Color(0, 0, 0)
var start_channel: String = "r"
var start_direction: int = 1
var step: float = 0.01

var color: Color
var channel: String
var direction: int

const COLOR_MAX: float = 0.8

func _init(_color: Color = Color(0,0,0), _channel: String = "r", _dir: int = 1, _step: float = 0.01):
	#start_color = _color
	#start_channel = _channel
	#start_direction = _dir

	color = _color
	channel = _channel
	direction = _dir
	step = _step
#
#func _process(delta: float) -> void:
	#_cycle(step)

func cycle(amount: float = step):
	match channel:
		"r":
			color.r = clamp(color.r + amount * direction, 0.0, COLOR_MAX)
			if color.r >= COLOR_MAX:
				_switch_channel("b", -1)
			elif color.r <= 0.0:
				_switch_channel("b", 1) # FIX: go to b+, not g-

		"g":
			color.g = clamp(color.g + amount * direction, 0.0, COLOR_MAX)
			if color.g >= COLOR_MAX:
				_switch_channel("r", -1) # FIX: g+ leads to b+
			elif color.g <= 0.0:
				_switch_channel("r", 1) # FIX: g- leads to r-

		"b":
			color.b = clamp(color.b + amount * direction, 0.0, COLOR_MAX)
			if color.b >= COLOR_MAX:
				_switch_channel("g", -1)
			elif color.b <= 0.0 and direction == -1:
				_switch_channel("g", 1)

func _switch_channel(new_channel: String, new_direction: int):
	channel = new_channel
	direction = new_direction

func get_color() -> Color:
	return color
