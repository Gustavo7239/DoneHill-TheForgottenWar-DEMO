extends Node

var save_path = "user://save_game.dat"

var music_volume_level = 0
var fx_volume_level = 0

var music_volume_level_slider = 90
var fx_volume_level_slider = 90

const MAX_SOULS_POINTS : int = 400		#Puntos de alma maximos

var Player_HP : int = 4					#Puntos de vida del Player actual
const MAX_Player_HP : int = 4			#Puntos maximos de vida del Player

var Player_can_Heal : bool = true		#Tiene disponible la habilidad de curarse o no
var Player_can_Dash : bool = true		#Tiene disponible la habilidad de dashearse o no
var Player_can_DobleJump : bool = true	#Tiene disponible la habilidad de doble salto o no

var MUSIC_VOLUME : float = 0.0			#Volumen general de la musica
var SOUNDFX_VOLUME : float = 0.0		#Volumen general de los efectos de sonido

var CAMERA : Camera2D					#Camara global del juego

var game_data : Dictionary = {
	"MUSIC_VOLUME" : 0.0,				#Volumen general de la musica
	"SOUNDFX_VOLUME" : 0.0,				#Volumen general de los efectos de sonido
	
	"SoulPoints" : 400,					#Puntos de alma del Player
	
	"Player_HP" : 4,					#Puntos de vida del Player actual
	
	"Player_can_Heal" : true,			#Tiene disponible la habilidad de curarse o no
	"Player_can_Dash" : true,			#Tiene disponible la habilidad de dashearse o no
	"Player_can_DobleJump" : true,		#Tiene disponible la habilidad de doble salto o no
	
	"Player_Position" : Vector2.ZERO, 	#Posicion del jugador
	
	"LastScene" : "bosque_lvl",
	"LastReSpawnPoint": Vector2.ZERO
}

var SoulPoints = game_data["SoulPoints"]#Puntos de alma del Player

func save_game() -> void:
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	save_file.store_var(game_data)
	save_file = null
	
	print("GAME SAVED")

func load_game() -> void:
	if FileAccess.file_exists(save_path):
		var save_file = FileAccess.open(save_path, FileAccess.READ)
		game_data = save_file.get_var()
		save_file = null
		
		print("-------------- GAME LOADED --------------")
		print(game_data["Player_HP"])
		print(game_data["Player_Position"].x)
		print(game_data["Player_Position"].y)
		print("-----------------------------------------")

func Reload_Player_Settings(player : Player, IsSpawn : bool):
	if IsSpawn:
		if game_data["Player_Position"] != Vector2.ZERO:
			player.global_position = game_data["Player_Position"]
		
	player.Player_HealingPoints = GLOBAL.game_data["Player_HP"]
	
	player.Can_Heal = GLOBAL.game_data["Player_can_Heal"]
	player.Can_Dash = GLOBAL.game_data["Player_can_Dash"]
