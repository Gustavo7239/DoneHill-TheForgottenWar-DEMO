extends Node

const dev_lvl = preload("res://Terrains/Dev_terrain/Scene/Dev_terrain.tscn")
const bosque_lvl = preload("res://Terrains/Bosque_terrain/Scene/Bosque_main.tscn")

const MAIN_MENU = preload("res://GUI/Main_menu/MainMenu.tscn")
const OPCIONES_MENU = preload("res://GUI/Options_menu/OpcionesMenu.tscn")

signal on_trigger_player_spawn

var spawn_door_tag

func go_to_level(level_tag, destination_tag):
	var scene_to_load
	
	match level_tag:
		"Dev_lvl":
			scene_to_load = dev_lvl
		"Bosque_lvl":
			scene_to_load = bosque_lvl
			
	if scene_to_load != null:
		TransitionerScreen.transition()
		await TransitionerScreen.on_transition_finished
		spawn_door_tag = destination_tag
		get_tree().change_scene_to_packed(scene_to_load)

func change_Scene(scene_tag):
	var scene_to_load
	
	match scene_tag:
		"MAIN_MENU":
			scene_to_load = MAIN_MENU
		"Dev_lvl":
			scene_to_load = dev_lvl
		"OPTIONS_MENU":
			scene_to_load = OPCIONES_MENU
			
	if scene_to_load != null:
		TransitionerScreen.transition()
		await TransitionerScreen.on_transition_finished
		get_tree().change_scene_to_packed(scene_to_load)
		
func spawnPlayerCheckPoint(scene):
	var scene_to_load
	match scene:
		"bosque_lvl":
			scene_to_load = bosque_lvl
	
	TransitionerScreen.transition()
	await TransitionerScreen.on_transition_finished
	get_tree().change_scene_to_packed(scene_to_load)

func appear_Scene():
	TransitionerScreen.transition()

func Trigger_player_spawn(position: Vector2, direction: String):
	GLOBAL.save_game()
	on_trigger_player_spawn.emit(position, direction)
