extends Node
@onready var player = $Player

func _ready():
	GLOBAL.load_game()
	loadPlayerData()
	
	

func loadPlayerData():
	if GLOBAL.game_data["Player_Position"] != Vector2.ZERO:
		player.global_position = GLOBAL.game_data["Player_Position"]
		
	player.Player_HealingPoints = GLOBAL.game_data["Player_HP"]
	player.Can_Heal = GLOBAL.game_data["Player_can_Heal"]
	player.Can_Dash = GLOBAL.game_data["Player_can_Dash"]
