extends Area2D
class_name Dash_Skill

@export_category("config")
@export_group("Required References")
@export var player : Player

@export_group("Movement settings")
@export var dash_speed : int = 4000
@export var dash_duration : float = 0.2
@export var dash_cooldown : float = 1

#NODOS DEL OBJETO --------------------------------
@onready var sprite = $Sprite
#Tools
@onready var fx_controller = $Tools/FxController
#SoundFx
@onready var dash_sound_fx = $Audio/Dash_sound_fx
#Collisions
@onready var collision_make_dmg = $AreaHit/Collision_Make_DMG
#Timer
@onready var cooldown_timer = $Cooldown


var Is_Activated : bool = GLOBAL.Player_can_Dash
var Is_on_cooldown : bool = false
var hability_lvl : int = 3

func _ready():
	cooldown_timer.set_wait_time(dash_cooldown)
	
func _process(delta):
	global_position = player.global_position
	scale.x = player.get_axis().x
	dash_sound_fx.volume_db = GLOBAL.SOUNDFX_VOLUME

func _on_area_hit_body_entered(body):
	if body as BasicEnemy and hability_lvl >= 3:
		body.damage_ctrl(1)

func dash_ctrl():
	if Is_Activated  and not Is_on_cooldown : 
		player.disappear()
		
		in_function_lvl()
		
		player.velocity.x = player.get_axis().x * dash_speed
		player.velocity.y = 0
		
		fx_controller.click()
		player.move_and_slide()
		Is_on_cooldown = true
		cooldown_timer.start()
		
func _on_cooldown_timeout():
	Is_on_cooldown = false
	fx_controller.turn_off_vibration()

func in_function_lvl():
	if hability_lvl >= 1:
		player.velocity.x = player.get_axis().x * dash_speed
		player.velocity.y = 0
		dash_sound_fx.play()
		
	if hability_lvl >= 2:
		collision_make_dmg.disabled = false
		
	if hability_lvl >= 3:
		player.atraviesa_enemies()
		
	sprite.play("On")

func _on_sprite_animation_finished():
	sprite.set_animation("Off")
	collision_make_dmg.disabled = true
	player.no_atraviesa_enemies()
	player.appear()
		
