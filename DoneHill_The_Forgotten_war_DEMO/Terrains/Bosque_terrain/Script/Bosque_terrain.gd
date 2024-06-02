extends Node

@onready var player = $Player

func _ready():
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)
	
		GLOBAL.Reload_Player_Settings(player, false)

func _on_level_spawn(destination_tag: String):
	var door_path = "Doors/Door_" + destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.Trigger_player_spawn(door.spawn.global_position, door.spawn_direction)
