extends Control

@onready var opciones_menu = $OpcionesMenu
@onready var menu = $BackGround/Menu

@onready var play_button = $BackGround/Menu/VBoxContainer/PlayButton

@onready var fire_place = $Audio/SoundFX/FirePlace
@onready var background_music = $Audio/Music/BackgroundMusic
@onready var wind = $Audio/SoundFX/Wind

func _ready():
	GLOBAL.load_game()
	play_button.grab_focus()

func _process(delta):
	background_music.volume_db = GLOBAL.game_data["MUSIC_VOLUME"]
	fire_place.volume_db = GLOBAL.game_data["SOUNDFX_VOLUME"]
	wind.volume_db = GLOBAL.game_data["SOUNDFX_VOLUME"]

func _on_play_button_pressed():
	NavigationManager.spawnPlayerCheckPoint(GLOBAL.game_data["LastScene"])
	
func _on_salir_button_pressed():
	get_tree().quit()

func _on_opciones_button_pressed():
	NavigationManager.change_Scene("OPTIONS_MENU")
	#opciones_menu.visible = not opciones_menu.visible
	#menu.visible = not menu.visible
