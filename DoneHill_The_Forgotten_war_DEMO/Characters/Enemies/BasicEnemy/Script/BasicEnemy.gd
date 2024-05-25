extends CharacterBody2D
class_name BasicEnemy

@export_category("Config")

@export_group("Options")
@export var Enemy_HP : int = 100			#Puntos de vida
@export var Soul_Points : int = 100			#Puntos de alma que soltara al morir

@export_group("Motion")
@export var TargetSpeed : int = 50		#Velocidad de cuando encuentra al player
@export var NormalSpeed : int = 16		#Velocidad normal
var CurrentSpeed : int = NormalSpeed	#Velocidad actual
@export var Gravity	: int = 16			#Gravedad 

#NODOS DEL OBJETO --------------------------------
@onready var sprite = $Sprite
@onready var ray_ground = $Sprite/RayGround
@onready var collision_body = $Collision_Body

var Orientation : int = 1				#Orientacion del personaje

func _process(delta):
	if Enemy_HP > 0:
		motion_ctrl()

func motion_ctrl() -> void:
	sprite.scale.x = Orientation
	
	if not ray_ground.is_colliding() or is_on_wall():
		Orientation *= -1

	velocity.x = Orientation * CurrentSpeed
	velocity.y += Gravity
	move_and_slide()

func damage_ctrl(damage : int) -> void:
	Enemy_HP -= damage
	if Enemy_HP <= 0:
		sprite.set_animation("Death")
		collision_body.set_deferred("disabled", true)
		Gravity = 0
		Give_Points()
		
func Give_Points():
	if GLOBAL.SoulPoints + GLOBAL.MAX_SOULS_POINTS < GLOBAL.MAX_SOULS_POINTS :
		GLOBAL.SoulPoints += Soul_Points
	elif GLOBAL.SoulPoints + GLOBAL.MAX_SOULS_POINTS >= GLOBAL.MAX_SOULS_POINTS :
		GLOBAL.SoulPoints = GLOBAL.MAX_SOULS_POINTS

func _on_sprite_animation_finished():
	if sprite.animation == "Death":
		queue_free()

func _on_area_hit_body_entered(body):
	if body as Player and Enemy_HP > 0:
		body.damage_ctrl()
