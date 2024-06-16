extends Node2D

@onready var player:Player = $Player


func _process(delta):
	if GLOBAL.game_data["Player_HP"] < 1:
		NavigationManager.change_Scene("DEATH_SCENE")
