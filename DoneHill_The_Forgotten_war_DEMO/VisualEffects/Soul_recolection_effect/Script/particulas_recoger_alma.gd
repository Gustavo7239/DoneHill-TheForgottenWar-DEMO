extends GPUParticles2D

@export_category("Config")

@export_group("Target_options")
@export var destinationPoint: LightOccluder2D

@onready var timer = $Timer
@onready var text_edit: TextEdit = $"../TextEdit"

# Velocidad máxima permitida
var max_speed: float = 300
var original_position = position

func _ready():
	set_process(true)

func cambiar_posicion():
		position = destinationPoint.position

func _process(delta):
	text_edit.text = str(position)

func _on_timer_timeout():
	cambiar_posicion()


func _on_button_pressed():
	position = original_position
#	Reinicia la animacion, lo cual es mejor para usar en vez del emitting = true, ya que tiene delay
	restart()
	timer.start()
