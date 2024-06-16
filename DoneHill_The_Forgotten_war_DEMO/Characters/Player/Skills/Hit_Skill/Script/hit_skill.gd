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
	player.sprite.visible = false
	player.make_damage.disabled = false
	player.sprite_alter_para_hit.visible = true
	player.animation_player_for_hit.play("DoubleHit")


func _on_animation_player_animation_finished(anim_name):
	player.sprite_alter_para_hit.visible = false
	player.make_damage.disabled = true
	player.sprite.visible = true


func _on_make_damage_body_entered(body):
	match body:
		null: 
			player.Test.text = "No"
		_:
			player.Test.text = str(body)
	if body as BasicEnemy:
		body.damage_ctrl(player.damage)
