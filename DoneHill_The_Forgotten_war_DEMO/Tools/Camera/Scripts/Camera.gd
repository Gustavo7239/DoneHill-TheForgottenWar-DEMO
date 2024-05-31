extends Camera2D

@export_category("Config")

@export_group("Required references")
@export var player : CharacterBody2D

var shake_amount : float = 0
var default_offset : Vector2 = offset
var pos_x : int 
var pos_y : int

@onready var shake_timer = $Timers/Shake_timer
@onready var zoom_timer = $Timers/Zoom_timer


@onready var tweenShake : Tween = create_tween()
var can_shake : bool = false
@onready var tweenZoom : Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
var pasar : bool = false

var activarCamera : bool = false

var zoomSpeed = 100
var zoomMin = 0.2
var zoomMax = 1.2
var zoomFactor = 1.0

func _ready():
	set_process(true)
	GLOBAL.CAMERA = self
	randomize()
	
func _process(delta):
	if can_shake:
		offset = Vector2(randf_range(-1, 1) * shake_amount, randf_range(-1, 1) * shake_amount)
		
	if activarCamera:
		if pasar:
			zoom.x = lerp(zoom.x, zoom.x * zoomFactor, zoomSpeed * delta)
			zoom.y = lerp(zoom.y, zoom.y * zoomFactor, zoomSpeed * delta)
			
			zoom.x = clamp(zoom.x, zoomMin, zoomMax)
			zoom.y = clamp(zoom.y, zoomMin, zoomMax)
		else:
			if zoomFactor > 1:
				zoomFactor -= 0.01
			elif zoomFactor < 1:
				zoomFactor += 0.01
			
			zoom.x = lerp(zoom.x, zoomFactor, zoomSpeed * delta)
			zoom.y = lerp(zoom.y, zoomFactor, zoomSpeed * delta)
			
			zoom.x = clamp(zoom.x, zoomMin, zoomMax)
			zoom.y = clamp(zoom.y, zoomMin, zoomMax)
			
			if zoom.x == 1.0:
				activarCamera = false

func shake(time: float, amount: float):
	shake_timer.wait_time = time
	shake_amount = amount
	can_shake = true
	shake_timer.start()

func _on_shake_timer_timeout() -> void:
	can_shake = false
	tweenShake.interpolate_value(self, "offset", 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)


func zoomFX(time: float, target_zoom: float):
	zoomFactor += 0.02
	pasar = true
	activarCamera = true

func zoomFX_Healing(target_zoom: float):
	zoomFactor += target_zoom
	pasar = true
	activarCamera = true

func normalCameraZoom():
	pasar = false
	

func _on_zoom_timer_timeout():
	var tweenx : Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tweenx.tween_property(self, "zoom", Vector2(1,1), 0.2)
	
func transitionZoom(distancia: float, time: float):
	var zoomVector = Vector2(distancia,distancia)
	tweenZoom.tween_property(self, "zoom", zoomVector, time)
	
