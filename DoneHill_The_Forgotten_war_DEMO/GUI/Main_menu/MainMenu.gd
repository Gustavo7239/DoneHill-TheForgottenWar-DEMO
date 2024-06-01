extends Control

@onready var opciones_menu = $OpcionesMenu
@onready var menu = $BackGround/Menu

@onready var play_button = $BackGround/Menu/VBoxContainer/PlayButton

func _ready():
	play_button.grab_focus()

func _on_play_button_pressed():
	NavigationManager.change_Scene("Dev_lvl")
	
func _on_salir_button_pressed():
	get_tree().quit()

func _on_opciones_button_pressed():
	NavigationManager.change_Scene("OPTIONS_MENU")
	#opciones_menu.visible = not opciones_menu.visible
	#menu.visible = not menu.visible
