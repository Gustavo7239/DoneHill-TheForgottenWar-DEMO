extends Camera2D

@export_category("Config")

@export_group("Required references")
@export var player : CharacterBody2D

func _process(delta):
	global_position = player.global_position
