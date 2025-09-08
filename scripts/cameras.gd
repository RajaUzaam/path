extends Node3D

@export var player: CharacterBody3D

func _process(_delta):
	if player == null or !GV.game_started: return
	position = player.position
