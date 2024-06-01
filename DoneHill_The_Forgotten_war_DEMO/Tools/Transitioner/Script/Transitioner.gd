extends CanvasLayer

signal on_transition_finished

@onready var color_black = $ColorBlack
@onready var animation = $Animation

func _ready():
	color_black.visible = false
	animation.animation_finished.connect(_on_animation_animation_finished)

func _on_animation_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		on_transition_finished.emit()
		animation.play("fade_to_normal")
	elif anim_name == "fade_to_normal":
		color_black.visible = false

func transition():
	color_black.visible = true
	animation.play("fade_to_black")
