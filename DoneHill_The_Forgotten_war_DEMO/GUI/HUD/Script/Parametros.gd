extends TextEdit

func _process(delta):
	text = "Soul points: " +str(GLOBAL.game_data["SoulPoints"]) + "\nH"
