extends PointLight2D

@export var player: CharacterBody2D

func _process(delta):
	follow_player()

func follow_player():
	position.x = player.position.x
