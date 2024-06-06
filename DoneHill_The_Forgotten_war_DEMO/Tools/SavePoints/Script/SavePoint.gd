extends Area2D

@export_category("config")
@export_group("Required References")
@export var SpawnScene : Node2D

@onready var sit_position = $AreaCollision/SitPosition
@onready var cooldown_sitting = $CooldownSitting

@onready var playerSit : Player
var WaitForPlayer : bool = false

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if WaitForPlayer:
		if Input.is_action_pressed("Interact"):
			sitting()

func _on_area_collision_body_entered(body):
	if body as Player:
		playerSit = body
		WaitForPlayer = true
			
func sitting():
	playerSit.global_position = sit_position.global_position
	playerSit.IsSitting = true
	playerSit.sprite.set_animation("Sit_In")
	beneficts()
	cooldown_sitting.start(2)
	WaitForPlayer = false

func _on_cooldown_sitting_timeout():
	playerSit.IsSitting = false
	
func beneficts():
	GLOBAL.game_data["Player_HP"] = GLOBAL.MAX_Player_HP
	GLOBAL.game_data["SoulPoints"] = GLOBAL.MAX_SOULS_POINTS
	GLOBAL.save_game()
	GLOBAL.Reload_Player_Settings(playerSit,false)
	
func saveWorldUbication():
	GLOBAL.game_data["LastScene"] = SpawnScene
	GLOBAL.game_data["LastReSpawnPoint"] = sit_position
