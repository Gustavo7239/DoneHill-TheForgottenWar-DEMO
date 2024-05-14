extends Area2D
class_name Sensor

@export_category("Config")

@export_group("Required References")
@export var VisionRange : float = 90.0

var target : CollisionObject2D
var collisiones = []

@onready var rangoColision : CollisionShape2D = $CollisionShape2D

var target_distance : get = _get_distance
var target_direction : get = _get_direction

func _get_direction():
	return target.global_position - global_position
	
func _get_distance() -> float:
	return global_position.distance_to(target.global_position)

func _ready():
	body_entered.connect(store_body)
	body_exited.connect(remove_body)
	set_circle_radius(VisionRange)
	print(rangoColision.shape.radius)

func store_body(body):
	collisiones.append(body)
	
func  remove_body(body):
	collisiones.erase(body)
	
	if collisiones.size() == 0:
		target = null

func _physics_process(delta):
	scan()

func scan() -> void:
	if collisiones.size() == 0:
		return
		
	var closestBody = find_closest_body(collisiones)
	if closestBody != null:
		target = closestBody
	else:
		target = null

func find_closest_body(bodies: Array) -> CollisionObject2D:
	var closestDistance = 1000
	var closestBody = null
	
	if bodies.size() == 0:
		target = null
		return 
	
	for body in bodies:
		if body != null:
			var distance = body.global_position.distance_to(global_position)
			if distance < closestDistance:
				closestDistance = distance
				closestBody = body
				target = closestBody
	
	return closestBody

func set_circle_radius(radius: float) -> void:
	if rangoColision.shape is CircleShape2D:
		var circle_shape : CircleShape2D = rangoColision.shape
		circle_shape.radius = radius
		rangoColision.shape = circle_shape
	else:
		print("El CollisionShape2D no tiene una forma de CircleShape2D asociada.")
