extends CanvasLayer

@onready var guante = $Guante

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match GLOBAL.game_data["Player_HP"]:
		4: guante.frame = 1
		3: guante.frame = 2
		2: guante.frame = 3
		1: guante.frame = 4
		0: guante.frame = 5
