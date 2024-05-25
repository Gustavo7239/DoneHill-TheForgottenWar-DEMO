extends Control

@onready var opciones_menu = $OpcionesMenu
@onready var menu = $Menu



@export_file('*.tscn') var change_scene
#Cargara el juego
func _on_play_button_pressed():

	get_tree().change_scene_to_file(change_scene)
#Saldra del juego
func _on_salir_button_pressed():
	get_tree().quit()


func _on_opciones_button_pressed():
	opciones_menu.visible = not opciones_menu.visible
	menu.visible = not menu.visible

