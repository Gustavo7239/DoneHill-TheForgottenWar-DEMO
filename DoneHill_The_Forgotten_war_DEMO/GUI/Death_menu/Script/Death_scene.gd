extends Control

@onready var player = $Player
@onready var press_any_button = $"PRESS ANY BUTTON"
@onready var press_any_button_label = $PressAnyButtonLabel
@onready var idle_player = $IdlePlayer

func _ready():
	press_any_button_label.visible = false

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		#Salir del juego
		pass

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "DeathAnim":
		press_any_button.play("OnOff")
