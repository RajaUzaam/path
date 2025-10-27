extends Area3D

@onready var score_audio: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var death_anim: AnimationPlayer = $DeathAnim
var entered: bool = false
func _on_body_entered(body):
	if body.name == 'Player' and !entered:
		PD.score += 1
		%Star.queue_free()
		entered = true
		death_anim.play("collect")


func _on_audio_stream_player_3d_finished() -> void:
	pass#queue_free()


func _on_gpu_particles_3d_finished() -> void:
	pass#queue_free()

func _on_death_anim_animation_finished(_anim_name: StringName) -> void:
	queue_free()
