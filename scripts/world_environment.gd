extends WorldEnvironment

@export var path: Node3D

#var panorama_sky: PanoramaSkyMaterial
#var grad_tex: GradientTexture2D
#var last_color: Color = Color(-1, -1, -1, -1)
#
#const COLOR_TOLERANCE: float = 0.01
#
#func _ready() -> void:
	## get the existing PanoramaSky on the environment
	#panorama_sky = environment.sky.sky_material
#
	## create initial gradient texture (kept and reused)
	#var initial_grad: Gradient = Gradient.new()
	#initial_grad.add_point(0.0, Color(0,0,0))     # bottom
	#initial_grad.add_point(0.5, Color(0.5,0.5,0.5))# horizon
	#initial_grad.add_point(1.0, Color(1,1,1))     # top
#
	#grad_tex = GradientTexture2D.new()
	#grad_tex.gradient = initial_grad
	#grad_tex.width = 512
	#grad_tex.height = 128
	#grad_tex.fill = GradientTexture2D.FILL_LINEAR
	#grad_tex.fill_from = Vector2(0, 1) # bottom
	#grad_tex.fill_to   = Vector2(0, 0) # top
#
	## assign once
	#panorama_sky.panorama = grad_tex
#
#func _process(_delta: float) -> void:
	#if panorama_sky == null:
		#return
#
	#var base: Color = path.tile_rgb.get_color()
#
	## component-wise tolerance check (cheap)
	#if abs(base.r - last_color.r) < COLOR_TOLERANCE \
	#and abs(base.g - last_color.g) < COLOR_TOLERANCE \
	#and abs(base.b - last_color.b) < COLOR_TOLERANCE:
		#return
#
	## update cache
	#last_color = base
#
	## get HSV and enforce minimal vibrancy so sky never looks grey/black
	#var h: float = base.h
	#var s: float = clamp(base.s, 0.45, 0.95)
	#var v: float = clamp(base.v, 0.55, 0.95)
#
	## build contrasting stops (you can tweak multipliers)
	#var top    : Color = Color.from_hsv(h, min(s * 1.25, 1.0), min(v * 1.18, 1.0))
	#var midtop : Color = Color.from_hsv(h, s, min(v * 1.00, 1.0))
	#var horizon: Color = Color.from_hsv(fmod(h + 0.5, 1.0), s * 0.85, v * 0.92) # complementary-ish
	#var midbot : Color = Color.from_hsv(fmod(h + 0.25, 1.0), s * 0.72, v * 0.62)
	#var bottom : Color = Color.from_hsv(fmod(h + 0.1, 1.0), s * 0.60, v * 0.35)
#
	## create a fresh Gradient and assign it to the existing GradientTexture2D
	#var new_grad: Gradient = Gradient.new()
	#new_grad.add_point(0.0, bottom)
	#new_grad.add_point(0.25, midbot)
	#new_grad.add_point(0.5, horizon)
	#new_grad.add_point(0.75, midtop)
	#new_grad.add_point(1.0, top)
#
	#grad_tex.gradient = new_grad
