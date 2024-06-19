extends BasicEnemy
class_name Slime

@export_category("Config")

@export_group("Slime Motion")
@export var jump_power : int = 368
@export var attack_range : int = 50

# Área de detección
@onready var sensor : Sensor = $Sprite/Sensor as Sensor

#NODOS DEL OBJETO --------------------------------
#@onready var sprite = $Sprite
#@onready var ray_ground = $Sprite/RayGround
#@onready var collision_body = $Collision_Body

var cooldownAttack : bool = false

func _process(delta):
	if Enemy_HP > 0:
		motion_ctrl()

func motion_ctrl() -> void:
	sprite.scale.x = Orientation
	
	if is_on_floor():
		if sensor.target != null:
			attack_ctrl()
		else:
			# No se detectó un jugador, continúa moviéndose con la animación "run"
			sprite.set_animation("Idle")
			if not ray_ground.is_colliding() or is_on_wall():
				Orientation *= -1
			CurrentSpeed = NormalSpeed
	
	velocity.x = Orientation * NormalSpeed
	velocity.y += Gravity
	move_and_slide()

func damage_ctrl(damage : int) -> void:
	Enemy_HP -= damage
	if Enemy_HP <= 0:
		collision_body.disabled = true
		sprite.play("Death")
		Gravity = 0
		Give_Points()
		
func _on_sprite_animation_finished():
	if sprite.animation == "Death":
		queue_free()

func jump_ctrl(power : float) -> void:
	match is_on_floor():
		true:
			sprite.play("Jump")
			velocity.y = -jump_power * power
		false:
			sprite.play("Fall")
			velocity.y += Gravity
			
	move_and_slide()
	

func set_focus_on_player(input_vector: Vector2):
	if input_vector.x > 0:
		Orientation = 1
	else:
		Orientation = -1
	
	move_and_slide()

func attack_ctrl() -> void:
	sprite.set_animation("Run")
	CurrentSpeed = TargetSpeed
			
	if sensor.target_distance > attack_range:
		set_focus_on_player(sensor.target_direction)
	elif sensor.target_distance <= attack_range:
		jump_ctrl(0.75)
	


