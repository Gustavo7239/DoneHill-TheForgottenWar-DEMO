extends Control

@onready var wait_timer = $Wait_timer
@onready var black = $Black
@onready var lbl_continue = $LblContinue

var tween : Tween 
var time_to_wait : float = 4

func _ready():
	tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	black.modulate = Color(1,1,1,1)
	shadows_DISAPPEAR()

func _input(event):
	if event is InputEventMouseButton:
		print("mouse button event at ", event.position)

func _process(delta):
	if Input.is_action_pressed("Jump_skill"):
		changeScene()
	
	var continueButton = InputMap.action_get_events("Jump_skill")[0].as_text()
	
	lbl_continue.text = "Press " + continueButton + " to continue"

func shadows_DISAPPEAR():
	showShadow(false)
	showShadow(true)
	tween.connect("finished",changeScene)

func changeScene():
	get_tree().change_scene_to_file("res://GUI/Main_menu/MainMenu.tscn")

func showShadow(value : bool):
	match value:
		true:
			tween.tween_property(black, "modulate", Color(1,1,1,1), time_to_wait)
		false:
			tween.tween_property(black, "modulate", Color(1,1,1,0), time_to_wait)
