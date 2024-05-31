extends Control

@onready var opciones_menu = $OpcionesMenu
@onready var menu = $menu

@onready var pause_menu = $"."

@export_file('*.tscn') var change_scene

func _on_button_continuar_pressed():
	visible = not visible


func _on_button_menu_principal_pressed():
	get_tree().change_scene_to_file(change_scene)


func _on_button_opciones_pressed():
	opciones_menu.visible = not opciones_menu.visible
	menu.visible = not menu.visible
