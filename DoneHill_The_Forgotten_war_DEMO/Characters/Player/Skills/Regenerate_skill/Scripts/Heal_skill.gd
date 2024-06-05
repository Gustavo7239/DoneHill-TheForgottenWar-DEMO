extends Area2D
class_name Healing_Skill

@export_category("config")
@export_group("Required References")
@export var player : Player
@export var player_casting_speed : float = 10
@export var casting_time : float = 2
@export var heal_cooldown : float = 50
@export var points_to_heal : int = 199

#NODOS DEL OBJETO --------------------------------
@onready var sprite = $Sprite
@onready var heal_particles = $heal_particles

#Timers
@onready var casting_timer = $Timers/Casting_timer
@onready var cooldown_timer = $Timers/Cooldown_timer
#Tools
@onready var fx_controller = $Tools/FxController
#SoundFX
@onready var healing_skill_sound_fx_start = $Audio/HealingSkill_SoundFX_Start
@onready var healing_skill_sound_fx_in = $Audio/HealingSkill_SoundFX_In
@onready var healing_skill_sound_fx_final = $Audio/HealingSkill_SoundFX_Final
@onready var healing_skill_sound_fx_cancel = $Audio/HealingSkill_SoundFX_Cancel

var Is_Activated : bool = GLOBAL.game_data["Player_can_Heal"]
var Is_on_cooldown : bool = false
var Is_Charging : bool = false

@onready var tweenSubstractHP : Tween 

func _ready():
	casting_timer.set_wait_time(casting_time)
	healing_skill_sound_fx_start.volume_db = GLOBAL.fx_volume_level
	healing_skill_sound_fx_in.volume_db = GLOBAL.fx_volume_level
	healing_skill_sound_fx_final.volume_db = GLOBAL.fx_volume_level
	healing_skill_sound_fx_cancel.volume_db = GLOBAL.fx_volume_level

func _process(delta):
	updateSoundFX_Volume()

func cargar_ctrl():
	if Is_Activated and not Is_Charging and not Is_on_cooldown : 
		if GLOBAL.game_data["Player_HP"] < GLOBAL.MAX_Player_HP and GLOBAL.game_data["SoulPoints"] >= points_to_heal:
			sprite.play("Start")
			heal_particles.emitting = true
			GLOBAL.CAMERA.zoomFX_Healing(0.02)
			healing_skill_sound_fx_start.play()
			
			reduce_score_progressively()
			
			healing_skill_sound_fx_in.play()
			player.set_Slow_velocity(player_casting_speed)
			fx_controller.chargin()
			casting_timer.start()
			Is_Charging = true

var original_score

func reduce_score_progressively():
	# Guarda el puntaje original
	original_score = GLOBAL.game_data["SoulPoints"]
	var audio_duration = healing_skill_sound_fx_in.stream.get_length()
	
	tweenSubstractHP = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tweenSubstractHP.tween_property(GLOBAL, "SoulPoints", original_score - points_to_heal, audio_duration)
	tweenSubstractHP.connect("finished",substract)
	
func _on_cooldown_timer_timeout():
	Is_on_cooldown = false

func cancel_charge():
	if GLOBAL.game_data["Player_HP"] < GLOBAL.MAX_Player_HP and GLOBAL.game_data["SoulPoints"] >= points_to_heal:
		heal_particles.emitting = false
		sprite.play("Finish")
		GLOBAL.CAMERA.normalCameraZoom()
		healing_skill_sound_fx_start.stop()
		healing_skill_sound_fx_in.stop()
		fx_controller.turn_off_vibration()
		player.restore_velocity()
		healing_skill_sound_fx_cancel.play()
		Is_Charging = false
		casting_timer.stop()
		
		tweenSubstractHP.stop()
		
		Is_on_cooldown = true	
		cooldown_timer.start()

func _on_healing_skill_sound_fx_in_finished():
	if Is_Charging:
		sprite.play("Finish")
		GLOBAL.CAMERA.normalCameraZoom()
		healing_skill_sound_fx_final.play()
		player.restore_velocity()
		player.Player_HealingPoints += 1
		Is_Charging = false
		Is_on_cooldown = true
		cooldown_timer.start()
	fx_controller.turn_off_vibration()

func _on_sprite_animation_finished():
	if sprite.animation == "Start":
		player.sprite.play("Heal_skill_2")
		sprite.play("Charge")
	elif sprite.animation == "Charge":
		sprite.play("Keep")
	elif sprite.animation == "Finish":
		player.sprite.play("Idle")
		sprite.play("Off")
		heal_particles.emitting = false

func updateSoundFX_Volume():
	healing_skill_sound_fx_start.volume_db = GLOBAL.game_data["SOUNDFX_VOLUME"] 
	healing_skill_sound_fx_in.volume_db = GLOBAL.game_data["SOUNDFX_VOLUME"] 
	healing_skill_sound_fx_final.volume_db = GLOBAL.game_data["SOUNDFX_VOLUME"] 
	healing_skill_sound_fx_cancel.volume_db = GLOBAL.game_data["SOUNDFX_VOLUME"] 

func substract():
	GLOBAL.game_data["SoulPoints"] -= points_to_heal

func _on_casting_timer_timeout():
	pass
