extends Node

@onready var player = $Player
@onready var sit_position = $SavePoint/AreaCollision/SitPosition
@onready var wind = $Audio/SoundFX/Wind
@onready var birds = $Audio/SoundFX/Birds

func _process(delta):
	wind.volume_db = GLOBAL.game_data["SOUNDFX_VOLUME"]
	birds.volume_db = GLOBAL.game_data["SOUNDFX_VOLUME"]

func _ready():
	GLOBAL.load_game()
	
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)
		GLOBAL.Reload_Player_Settings(player, false)
	else:
		GLOBAL.Reload_Player_Settings(player, true)
		player.global_position = sit_position.global_position
		
		GLOBAL.game_data["Player_HP"] = GLOBAL.MAX_Player_HP
		GLOBAL.game_data["SoulPoints"] = GLOBAL.MAX_SOULS_POINTS
		GLOBAL.Reload_Player_Settings(player,false)

func _on_level_spawn(destination_tag: String):
	var door_path = "Doors/Door_" + destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.Trigger_player_spawn(door.spawn.global_position, door.spawn_direction)
