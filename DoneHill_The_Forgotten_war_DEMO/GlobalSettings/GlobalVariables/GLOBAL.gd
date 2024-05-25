extends Node

#var score : int
#var vidas : int
#var vidas_max : int = 5
#var contView : int
#
#var Healing_Points : int
#
#var Can_Heal : bool = true
#var Can_Dash : bool = true
#var Can_DobleJump : bool = true
#
#var Music_level : float = -20.0
#var SoundFX_level : float = -20.0
#
#var camera : Camera2D


var SoulPoints : int = 400				#Puntos de alma del Player
const MAX_SOULS_POINTS : int = 400		#Puntos de alma maximos

var Player_HP : int = 4					#Puntos de vida del Player actual
const MAX_Player_HP : int = 4			#Puntos maximos de vida del Player

var Player_can_Heal : bool = true		#Tiene disponible la habilidad de curarse o no
var Player_can_Dash : bool = true		#Tiene disponible la habilidad de dashearse o no
var Player_can_DobleJump : bool = true	#Tiene disponible la habilidad de doble salto o no

var MUSIC_VOLUME : float = 0.0			#Volumen general de la musica
var SOUNDFX_VOLUME : float = 0.0		#Volumen general de los efectos de sonido

var CAMERA : Camera2D					#Camara global del juego
