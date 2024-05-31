extends Area2D
class_name DobleJump_Skill

@export_category("config")
@export_group("Required References")
@export var player : Player
@export_group("Movement settings")
@export var jump : int = 368

#NODOS DEL OBJETO --------------------------------
@onready var sprite = $Sprite

@onready var jump_sound_fx = $Audio/Jump_soundFx
@onready var doble_jump_sound_fx = $Audio/DobleJump_soundFx

@onready var fx_controller = $FxController

var Is_Activated : bool = GLOBAL.game_data["Player_can_DobleJump"]
var Is_on_doblejump : bool = false

func _process(delta):
	jump_sound_fx.volume_db = GLOBAL.game_data["SOUNDFX_VOLUME"]
	doble_jump_sound_fx.volume_db = GLOBAL.game_data["SOUNDFX_VOLUME"]

func jump_action():
	match player.is_on_floor():
		true:
			Is_on_doblejump = false
			jump_ctrl(0.9)
			
		false:
			if not Is_on_doblejump and Is_Activated:
				Is_on_doblejump = true
				jump_ctrl(0.9)

func jump_ctrl(power : float) -> void:
	fx_controller.jump()
	player.velocity.y = -jump * power
	
	if Is_on_doblejump:
		if not player.is_on_floor():
			sprite.play("On")
			doble_jump_sound_fx.play()
	else:
		jump_sound_fx.play()

func _on_sprite_animation_finished():
	sprite.set_animation("Off")
