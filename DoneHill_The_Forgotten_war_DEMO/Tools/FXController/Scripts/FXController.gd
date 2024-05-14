extends Node

@onready var timer = $Timer

func _on_timer_timeout():
	turn_off_vibration()
	timer.stop()
	
func turn_off_vibration():
	Input.stop_joy_vibration(0)


func click() -> void:
	Input.start_joy_vibration(0,1,1,0)
	timer.start(0.2)

func jump() -> void:
	Input.start_joy_vibration(0,0.5,0,0)
	timer.start(0.1)
	
func chargin() -> void:
	Input.start_joy_vibration(0,0.3,0.3,0)
