extends Node

const dev_lvl = preload("res://Terrains/Dev_terrain/Scene/Dev_terrain.tscn")
const bosque_lvl = preload("res://Terrains/Bosque_terrain/Scene/Bosque_main.tscn")

const MAIN_MENU = preload("res://GUI/Main_menu/MainMenu.tscn")
const OPCIONES_MENU = preload("res://GUI/Options_menu/OpcionesMenu.tscn")
const DEATH_SCENE = preload("res://GUI/Death_menu/Scene/Death_scene.tscn")

const CUEVA_lvl = preload("res://Terrains/Cueva_terrain/Scene/Cueva_terrain.tscn")
const DESIERTO_lvl = preload("res://Terrains/Desierto_terrain/Scene/Desierto_terrain.tscn")

signal on_trigger_player_spawn

var spawn_door_tag

func go_to_level(level_tag, destination_tag):
	var scene_to_load
	
	match level_tag:
		"Dev_lvl":
			scene_to_load = dev_lvl
		"Bosque_lvl":
			scene_to_load = bosque_lvl
		"Cueva_lvl":
			scene_to_load = CUEVA_lvl
		"Desierto_lvl":
			scene_to_load = DESIERTO_lvl
			
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
		"DEATH_SCENE":
			scene_to_load = DEATH_SCENE
			
	if scene_to_load != null:
		TransitionerScreen.transition()
		await TransitionerScreen.on_transition_finished
		get_tree().change_scene_to_packed(scene_to_load)
		
func spawnPlayerCheckPoint(scene):
	var scene_to_load
	match scene:
		"Dev_lvl":
			scene_to_load = dev_lvl
		"Bosque_lvl":
			scene_to_load = bosque_lvl
		"Cueva_lvl":
			scene_to_load = CUEVA_lvl
		"Desierto_lvl":
			scene_to_load = DESIERTO_lvl
	
	TransitionerScreen.transition()
	await TransitionerScreen.on_transition_finished
	get_tree().change_scene_to_packed(scene_to_load)

func appear_Scene():
	TransitionerScreen.transition()

func Trigger_player_spawn(position: Vector2, direction: String):
	GLOBAL.save_game()
	on_trigger_player_spawn.emit(position, direction)
