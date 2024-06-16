extends Node2D

@onready var states = $AnimationTree
@onready var atack_cooldown = $AtackCooldown
@onready var end_fight_cooldown = $EndFightCooldown

@onready var boss_fight_sprite = $BossFightSprite


var randomAtack = RandomNumberGenerator.new()


var lastState:int = 0

func _ready():
	goAwake()

func _process(delta):
	pass

func goIdle():
	states["parameters/conditions/GoIdle"] = true
	states["parameters/conditions/GoAwake"] = false
	states["parameters/conditions/GoSpawn"] = false
	states["parameters/conditions/NumberOne"] = false
	states["parameters/conditions/NumberThree"] = false
	states["parameters/conditions/NumberTwo"] = false
	
func goAwake():
	states["parameters/conditions/GoIdle"] = false
	states["parameters/conditions/GoAwake"] = true
	states["parameters/conditions/GoSpawn"] = false
	states["parameters/conditions/NumberOne"] = false
	states["parameters/conditions/NumberThree"] = false
	states["parameters/conditions/NumberTwo"] = false

func goSpawn():
	states["parameters/conditions/GoIdle"] = false
	states["parameters/conditions/GoAwake"] = false
	states["parameters/conditions/GoSpawn"] = true
	states["parameters/conditions/NumberOne"] = false
	states["parameters/conditions/NumberThree"] = false
	states["parameters/conditions/NumberTwo"] = false

func goNumberOne():
	states["parameters/conditions/GoIdle"] = false
	states["parameters/conditions/GoAwake"] = false
	states["parameters/conditions/GoSpawn"] = false
	states["parameters/conditions/NumberOne"] = true
	states["parameters/conditions/NumberThree"] = false
	states["parameters/conditions/NumberTwo"] = false

func goNumberTwo():
	states["parameters/conditions/GoIdle"] = false
	states["parameters/conditions/GoAwake"] = false
	states["parameters/conditions/GoSpawn"] = false
	states["parameters/conditions/NumberOne"] = false
	states["parameters/conditions/NumberThree"] = true
	states["parameters/conditions/NumberTwo"] = false

func goNumberThree():
	states["parameters/conditions/GoIdle"] = false
	states["parameters/conditions/GoAwake"] = false
	states["parameters/conditions/GoSpawn"] = false
	states["parameters/conditions/NumberOne"] = false
	states["parameters/conditions/NumberThree"] = false
	states["parameters/conditions/NumberTwo"] = true


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "Wake_up":
		goSpawn()
	elif  not anim_name == "Idle" && not anim_name == "Wake_up":
		goIdle()
		atack_cooldown.start()
		end_fight_cooldown.start()

func _on_atack_cooldown_timeout():
	var number_atack = randomAtack.randi_range(1,3)
	match number_atack:
		1:
			goNumberOne()
		2:
			goNumberTwo()
		3:
			goNumberThree()


func _on_end_fight_cooldown_timeout():
	boss_fight_sprite.visible = false
