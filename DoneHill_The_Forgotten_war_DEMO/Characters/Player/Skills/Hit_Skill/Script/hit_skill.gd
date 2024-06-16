extends Node2D

class_name Hit_skill

@export_category("config")
@export_group("Required References")
@export var player : Player
@export var player_casting_speed : float = 10
@export var casting_time : float = 2
@export var hit_cooldown : float = 50
@export var damage_points : int = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func Hit():
	player.stopNormalMovement = true
	player.sprite.set_animation("Hit_normal_Right")
