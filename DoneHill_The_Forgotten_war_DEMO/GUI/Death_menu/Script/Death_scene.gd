extends Control

@onready var player = $Player
@onready var press_any_button = $"PRESS ANY BUTTON"
@onready var press_any_button_label = $PressAnyButtonLabel

func _ready():
	press_any_button_label.visible = false

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "DeathAnim":
		press_any_button.play("OnOff")
