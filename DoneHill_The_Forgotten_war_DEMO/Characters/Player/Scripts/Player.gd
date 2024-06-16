extends CharacterBody2D
class_name Player

var axis : Vector2 = Vector2.ZERO
var death : bool = false
var charging : bool = false

@export_category("config")
@export_group("Required References")
@export var gui : CanvasLayer
@export var Player_HealingPoints : int 
@export  var camera : Camera2D

@export_group("Motion")
@export var gravity : int = 16
@export var jump : int = 368
@export var normalSpeed : int = 120
var currentSpeed : int = normalSpeed

@export_category("Skills")
@export_group("Heal")
@export var Can_Heal : bool = true
@export_group("Dash")
@export var Can_Dash : bool = true

#-------------- NODOS DEL OBJETO --------------
@onready var sprite = $Sprite
#Skills
@onready var dash_skill = $Sprite/Skills/DashSkill
@onready var jump_skill = $Sprite/Skills/JumpSkill
@onready var heal_skill = $Sprite/Skills/HealSkill
@onready var hit_skill = $Sprite/Skills/HitSkill
#SoundFx
@onready var jump_fx = $Audio/JumpFx
@onready var recibe_damage_fx = $Audio/RecibeDamageFx
#Tools
@onready var fx_controller = $Tools/FxController

@onready var stopNormalMovement : bool = false

var IsSitting : bool = false

func _ready():
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	
func _on_spawn(position: Vector2, direction: String):
	global_position = position
	
	
func _process(delta):
	#GLOBAL.game_data["Player_can_Heal"] = Can_Heal
	jump_fx.volume_db = GLOBAL.game_data["SOUNDFX_VOLUME"]
	GLOBAL.game_data["Player_HP"] = Player_HealingPoints
	GLOBAL.game_data["Player_Position"] = position
	
	if Player_HealingPoints < 1:
		death = true
		
	match death:
		true:
			death_ctrl()
		false:
			if not IsSitting:
				motion_ctrl()

func _input(event):
	if not death:
		if event.is_action_pressed("Jump_skill"):
			jump_skill.jump_action()
			GLOBAL.save_game()

func get_axis() -> Vector2:
	axis.x = int(Input.is_action_pressed("Right_move")) - int(Input.is_action_pressed("Left_move"))
	return axis.normalized()

func motion_ctrl():
	'''MOVIMIENTO'''
	if Input.is_action_pressed("Heal_skill") and is_on_floor():
		heal_skill.cargar_ctrl()
	elif Input.is_action_just_released("Heal_skill") and not heal_skill.Is_on_cooldown and is_on_floor():
		heal_skill.cancel_charge() 
	elif Input.is_action_pressed("Dash_skill") and not get_axis().x == 0:
		dash_skill.dash_ctrl()
	elif Input.is_action_pressed("Hit_skill"):
		hit_skill.Hit()
		
	if not get_axis().x == 0:
		sprite.scale.x = get_axis().x
		
	velocity.x = get_axis().x * currentSpeed
	velocity.y += gravity
	
	move_and_slide()
	'''ANIMACIONES'''
	#if not hit_skill.Is_Hitting:
	#if !Input.is_action_pressed("Heal_skill") and !Input.is_action_pressed("Dash_skill"):
	if !stopNormalMovement:
		match is_on_floor():
			true:
				if not get_axis().x == 0:
					sprite.set_animation("Run")
				else:
					sprite.set_animation("Idle")
			false:
				if velocity.y < 0:
					sprite.set_animation("Jump")
				else:
					sprite.set_animation("Fall")

func death_ctrl():
	velocity.x = 0
	velocity.y *= gravity
	move_and_slide()
	NavigationManager.spawn_door_tag = null
	sprite.set_animation("Death")

func damage_ctrl(dmg : int = 1):
	recibe_damage_fx.play()
	#camera.apply_shake()
	print("daño:" ,dmg)
	print("vida:" , GLOBAL.game_data["Player_HP"] )
	print("---------------------------")
	
	if Player_HealingPoints - dmg < 1:
		Player_HealingPoints = 0
		death = true
	else:
		#jump_ctrl(0.5)
		GLOBAL.CAMERA.shake(0.5,1) 
		sprite.set_animation("Recibe_DMG")
		Player_HealingPoints -= dmg
		cooldown_hit()
		
	if Input.is_action_pressed("Heal_skill") and is_on_floor():
		heal_skill.cancel_charge() 
		
	GLOBAL.game_data["Player_HP"] = Player_HealingPoints

func set_Slow_velocity(slowVelocity : float) -> void:
	currentSpeed = slowVelocity

func restore_velocity() -> void:
	currentSpeed = normalSpeed

func disappear():
	sprite.visible = false

func appear():
	sprite.visible = true

func atraviesa_enemies():
	set_collision_mask_value(2, false)

func no_atraviesa_enemies():
	set_collision_mask_value(2, true)

func _on_sprite_animation_finished():
	if sprite.animation == "Death":
		NavigationManager.change_Scene("DEATH_SCENE")
	if sprite.animation == "Hit_normal_Right":
		stopNormalMovement = false
		
func cooldown_hit():
	velocity.y = -368 * 0.9
	velocity.x = -120 
	move_and_slide()
	
