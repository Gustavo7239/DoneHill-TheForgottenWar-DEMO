extends Control

@onready var music_level_slider_normalized = $HBoxContainer/VBoxContainer2/HBoxContainer/HSliderMusic
@onready var fx_level_slider_normalized = $HBoxContainer/VBoxContainer2/HBoxContainer/HSliderFX

@export var menu_back: Control

@onready var h_slider_music = $HBoxContainer/VBoxContainer2/HBoxContainer/HSliderMusic
@onready var h_slider_fx = $HBoxContainer/VBoxContainer2/HBoxContainer/HSliderFX

@onready var pruebas = $Pruebas

func _ready():
	h_slider_music.value = GLOBAL.music_volume_level_slider
	h_slider_fx.value = GLOBAL.fx_volume_level_slider

func _process(delta):
	pruebas.text = "Music level: " + str(GLOBAL.music_volume_level) + "\nFX level: " + str(GLOBAL.fx_volume_level)

func _on_h_slider_music_value_changed(value):
	music_level_slider_normalized = remap(value,0, 100, -40, 4)
	if music_level_slider_normalized == -40:
		music_level_slider_normalized = -80
	GLOBAL.music_volume_level = music_level_slider_normalized
	GLOBAL.music_volume_level_slider = h_slider_music.value
	
func _on_h_slider_fx_value_changed(value):
	fx_level_slider_normalized = remap(value,0, 100, -40, 4)
	if fx_level_slider_normalized == -40:
		fx_level_slider_normalized = -80
	GLOBAL.fx_volume_level = fx_level_slider_normalized
	GLOBAL.fx_volume_level_slider = h_slider_fx.value


func _on_button_pressed():
	h_slider_music.value = GLOBAL.music_volume_level_slider
	h_slider_fx.value = GLOBAL.fx_volume_level_slider
	menu_back.visible = not menu_back.visible
	visible = not visible
