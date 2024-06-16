extends Control

@onready var player = $Player
@onready var press_any_button = $"PRESS ANY BUTTON"
@onready var press_any_button_label = $PressAnyButtonLabel

func _ready():
	press_any_button_label.visible = false

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		GLOBAL.load_game()
		NavigationManager.spawnPlayerCheckPoint(GLOBAL.game_data["LastScene"])
		GLOBAL.game_data["Player_HP"] = GLOBAL.MAX_Player_HP
		GLOBAL.game_data["SoulPoints"] = GLOBAL.MAX_SOULS_POINTS

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "DeathAnim":
		press_any_button.play("OnOff")
