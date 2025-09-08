extends Node
class_name ColorControl

func setColor(color: Color, mesh_path: MeshInstance3D) -> void:
	var base_mat := mesh_path.get_active_material(0)
	var mat = base_mat.duplicate()
	mat.albedo_color = color
	mesh_path.set_surface_override_material(0, mat)

func get_complementary_color(color: Color) -> Color:
	var h: float = color.h
	var s: float = color.s
	var v: float = color.v
	# shift hue by 180° (0.5 in normalized [0,1] hue space)
	h = fmod(h + 0.5, 1.0)
	# optionally adjust saturation/value for aesthetics
	s = clamp(s * 1, 0.0, 1.0)
	v = clamp(v * 1, 0.0, 1.0)
	return Color.from_hsv(h, s, v, color.a)

func get_triadic_colors(color: Color) -> Array:
	var h: float = color.h
	var s: float = clamp(color.s * 0.85, 0.0, 1.0) # soften saturation
	var v: float = clamp(color.v * 0.95, 0.0, 1.0) # slightly dim
	var color1 = Color.from_hsv(h, s, v, color.a)
	var color2 = Color.from_hsv(fmod(h + 1.0/3.0, 1.0), s, v, color.a)
	var color3 = Color.from_hsv(fmod(h + 2.0/3.0, 1.0), s, v, color.a)
	return [color1, color2, color3]
