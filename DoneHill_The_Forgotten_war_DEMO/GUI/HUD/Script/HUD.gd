extends CanvasLayer

@onready var guante = $Guante

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GLOBAL.Player_HP == 4 :
		guante.frame = 1
	elif GLOBAL.Player_HP == 3 :
		guante.frame = 2
	elif GLOBAL.Player_HP == 2:
		guante.frame = 3
	elif GLOBAL.Player_HP == 1:
		guante.frame = 4
	elif GLOBAL.Player_HP == 0:
		guante.frame = 5
