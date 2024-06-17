extends Node2D

@onready var player:Player = $Player

@onready var montañita_dragon = $"Montañita dragon"
@onready var anim_caida:AnimationPlayer = $"Montañita dragon/AnimCaida"


func _process(delta):
	if GLOBAL.game_data["Player_HP"] < 1:
		NavigationManager.change_Scene("DEATH_SCENE")


func _on_caida_timeout():
	anim_caida.play("caida")
