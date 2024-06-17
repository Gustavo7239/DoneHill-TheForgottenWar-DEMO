extends Node2D

@onready var states = $AnimationTree
@onready var atack_cooldown = $AtackCooldown
@onready var end_fight_cooldown = $EndFightCooldown

@onready var boss_fight_sprite = $BossFightSprite
@onready var time_until_end = $TimeUntilEnd


var randomAtack = RandomNumberGenerator.new()

var battle_end = false

var lastState:int = 0

func _ready():
	goAwake()
	end_fight_cooldown.start()

func _process(delta):
	if battle_end:
		NavigationManager.change_Scene("CREDITOS_FINAL_SCENE")
	time_until_end.text = str(int(end_fight_cooldown.time_left))

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
	battle_end = true

func damage_player(body):
	if body as Player:
		body.damage_ctrl()

func _on_area_hit_body_entered(body):
	damage_player(body)
