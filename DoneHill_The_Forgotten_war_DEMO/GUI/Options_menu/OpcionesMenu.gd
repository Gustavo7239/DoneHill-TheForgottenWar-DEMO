extends Control

@onready var music_level_slider_normalized = $HBoxContainer/VBoxContainer2/HBoxContainer/HSliderMusic
@onready var fx_level_slider_normalized = $HBoxContainer/VBoxContainer2/HBoxContainer/HSliderFX

@export var menu_back: Control

@onready var h_slider_music = $HBoxContainer/VBoxContainer2/HBoxContainer/HSliderMusic
@onready var h_slider_fx = $HBoxContainer/VBoxContainer2/HBoxContainer/HSliderFX

@onready var pruebas = $Pruebas
@onready var audio_test = $Audio/Audio_Test


var MIN_VOLUME : int = 0
var MAX_VOLUME : int = 100
var MIN_VOLUME_SLIDER : int = -10
var MAX_VOLUME_SLIDER : int = 10

func _ready():
	GLOBAL.load_game()
	#h_slider_music.value = GLOBAL.game_data["MUSIC_VOLUME"]
	#h_slider_music.value = remap(GLOBAL.game_data["MUSIC_VOLUME"] ,MIN_VOLUME, MAX_VOLUME, MIN_VOLUME_SLIDER, MAX_VOLUME_SLIDER)
	h_slider_music.value = remap(GLOBAL.game_data["MUSIC_VOLUME"] ,MIN_VOLUME_SLIDER, MAX_VOLUME_SLIDER, MIN_VOLUME, MAX_VOLUME)
	
	#h_slider_fx.value = GLOBAL.game_data["SOUNDFX_VOLUME"]
	#h_slider_fx.value = remap(GLOBAL.game_data["SOUNDFX_VOLUME"] ,MIN_VOLUME, MAX_VOLUME, MIN_VOLUME_SLIDER, MAX_VOLUME_SLIDER)
	h_slider_fx.value = remap(GLOBAL.game_data["SOUNDFX_VOLUME"] ,MIN_VOLUME_SLIDER, MAX_VOLUME_SLIDER, MIN_VOLUME, MAX_VOLUME)
	
	h_slider_music.grab_focus()

func _process(delta):
	pruebas.text = "Music level: " + str(GLOBAL.game_data["MUSIC_VOLUME"]) + "\nFX level: " + str(GLOBAL.game_data["SOUNDFX_VOLUME"])
	#GLOBAL.game_data["MUSIC_VOLUME"] = h_slider_music.value
	#GLOBAL.game_data["SOUNDFX_VOLUME"] = h_slider_fx.value

func _on_h_slider_music_value_changed(value):
	#music_level_slider_normalized = remap(value ,MIN_VOLUME, MAX_VOLUME, MIN_VOLUME_SLIDER, MAX_VOLUME_SLIDER)
	GLOBAL.game_data["MUSIC_VOLUME"] = remap(value ,MIN_VOLUME, MAX_VOLUME, MIN_VOLUME_SLIDER, MAX_VOLUME_SLIDER)
	if GLOBAL.game_data["MUSIC_VOLUME"] == MIN_VOLUME_SLIDER:
		GLOBAL.game_data["MUSIC_VOLUME"] = -80
	#GLOBAL.music_volume_level_slider = h_slider_music.value
	audio_test.volume_db = GLOBAL.game_data["MUSIC_VOLUME"]
	audio_test.play()
	
func _on_h_slider_fx_value_changed(value):
	#fx_level_slider_normalized = remap(value ,MIN_VOLUME, MAX_VOLUME, MIN_VOLUME_SLIDER, MAX_VOLUME_SLIDER)
	#if fx_level_slider_normalized == -40:
	#	fx_level_slider_normalized = -80
	GLOBAL.game_data["SOUNDFX_VOLUME"] = remap(value ,MIN_VOLUME, MAX_VOLUME, MIN_VOLUME_SLIDER, MAX_VOLUME_SLIDER)
	if GLOBAL.game_data["SOUNDFX_VOLUME"] == MIN_VOLUME_SLIDER:
		GLOBAL.game_data["SOUNDFX_VOLUME"] = -80
	#GLOBAL.fx_volume_level_slider = h_slider_fx.value
	audio_test.volume_db = GLOBAL.game_data["SOUNDFX_VOLUME"]
	audio_test.play()


func _on_button_pressed():
	#h_slider_music.value = GLOBAL.music_volume_level_slider
	#h_slider_fx.value = GLOBAL.fx_volume_level_slider
	#menu_back.visible = not menu_back.visible
	#visible = not visible
	GLOBAL.save_game()
	NavigationManager.change_Scene("MAIN_MENU")
