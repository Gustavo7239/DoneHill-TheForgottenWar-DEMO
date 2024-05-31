extends Control

@onready var opciones_menu = $OpcionesMenu
@onready var menu = $BackGround/Menu

@onready var black = $Black
@onready var play_button = $BackGround/Menu/VBoxContainer/PlayButton

var tween : Tween
var time_to_wait : float = 2

func _ready():
	tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	black.modulate = Color(1,1,1,1)
	shadows_DISAPPEAR()
	play_button.grab_focus()

func shadows_DISAPPEAR():
	tween.tween_property(black, "modulate", Color(1,1,1,0), time_to_wait)
	tween.connect("finished",disapierBlack)


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

func disapierBlack():
	black.visible = false
	
