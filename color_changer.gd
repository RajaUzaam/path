extends Node
class_name ColorChanger

var start_color: Color = Color(0, 0, 0)
var start_channel: String = "r"
var start_direction: int = 1
var step: float = 0.01

var color: Color
var channel: String
var direction: int

const COLOR_MAX: float = 0.8
const SATURATION_SCALE: float = 0.975  # reduce saturation (0.0–1.0)

func _init(_color: Color = Color(0,0,0), _channel: String = "r", _dir: int = 1, _step: float = 0.01):
	color = _color
	channel = _channel
	direction = _dir
	step = _step

func cycle(amount: float = step):
	match channel:
		"r":
			color.r = clamp(color.r + amount * direction, 0.0, COLOR_MAX)
			if color.r >= COLOR_MAX:
				_switch_channel("b", -1)
			elif color.r <= 0.0:
				_switch_channel("b", 1)

		"g":
			color.g = clamp(color.g + amount * direction, 0.0, COLOR_MAX)
			if color.g >= COLOR_MAX:
				_switch_channel("r", -1)
			elif color.g <= 0.0:
				_switch_channel("r", 1)

		"b":
			color.b = clamp(color.b + amount * direction, 0.0, COLOR_MAX)
			if color.b >= COLOR_MAX:
				_switch_channel("g", -1)
			elif color.b <= 0.0 and direction == -1:
				_switch_channel("g", 1)

	# 🔹 reduce saturation every cycle
	var h: float = color.h
	var s: float = clamp(color.s * SATURATION_SCALE, 0.0, 1.0)
	var v: float = color.v
	color = Color.from_hsv(h, s, v, color.a)

func _switch_channel(new_channel: String, new_direction: int):
	channel = new_channel
	direction = new_direction

func get_color() -> Color:
	return color
