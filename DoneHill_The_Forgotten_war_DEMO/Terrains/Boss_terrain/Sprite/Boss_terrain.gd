extends Node2D

@onready var player:Player = $Player

@onready var montañita_dragon = $"Montañita dragon"
@onready var anim_caida:AnimationPlayer = $"Montañita dragon/AnimCaida"

func _process(delta):
	if GLOBAL.game_data["Player_HP"] < 1:
		NavigationManager.change_Scene("DEATH_SCENE")

func _on_caida_timeout():
	anim_caida.play("caida")

func _ready():
	GLOBAL.load_game()
	
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)
		GLOBAL.Reload_Player_Settings(player, false)
	else:
		GLOBAL.Reload_Player_Settings(player, true)

func _on_level_spawn(destination_tag: String):
	var door_path = "Doors/Door_" + destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.Trigger_player_spawn(door.spawn.global_position, door.spawn_direction)
