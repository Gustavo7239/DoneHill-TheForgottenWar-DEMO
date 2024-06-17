extends Area2D

class_name SavePoint

@export_category("config")
@export_group("Required References")
@export var BancoType : int

@onready var sit_position = $AreaCollision/SitPosition
@onready var cooldown_sitting = $CooldownSitting
@onready var sprite = $Sprite

@onready var SpawnScene : String
@onready var playerSit : Player
var WaitForPlayer : bool = false

func _ready():
	sprite.frame = BancoType
	switchSaveScene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if WaitForPlayer:
		if Input.is_action_pressed("Interact"):
			sitting()
			
func switchSaveScene():
	match BancoType:
		0:
			SpawnScene = "Bosque_lvl"
		1:
			SpawnScene = "Desierto_lvl"
		2:
			SpawnScene = "Cueva_lvl"
		3:
			SpawnScene = "Mon_lvl"
		4:
			SpawnScene = "Arena_lvl"

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
	saveWorldUbication()
	GLOBAL.save_game()
	GLOBAL.Reload_Player_Settings(playerSit,false)
	
func saveWorldUbication():
	GLOBAL.game_data["LastScene"] = SpawnScene
	GLOBAL.game_data["LastReSpawnPoint"] = sit_position
