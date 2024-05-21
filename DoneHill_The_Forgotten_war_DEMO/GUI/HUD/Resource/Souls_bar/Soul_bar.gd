extends Node2D

@onready var bar = $Bar
var SOUL_GRADIENT_BAR = preload("res://GUI/HUD/Resource/Souls_bar/Soul_gradient_bar.tres")
@onready var text_edit = $TextEdit

var puntos: float = 0.9

#func subir_bajar(points: float):
	#
	##text_edit.text = str(SOUL_GRADIENT_BAR.gradient.offsets[2])
	##SOUL_GRADIENT_BAR.gradient.offsets[2] = points
	#
	#var points_final = SOUL_GRADIENT_BAR.gradient.offsets[2]
	#var tween: Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	#tween.tween_property(SOUL_GRADIENT_BAR, ".gradiento.offsets[2]", points, 1.0)
#
	#
	
func subir(points: float):
	var points_final = SOUL_GRADIENT_BAR.gradient.offsets[2]
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN)

	tween.tween_method(_update_gradient_offset, points_final, points, 0.2)

func _update_gradient_offset(value: float):
	var offsets = SOUL_GRADIENT_BAR.gradient.offsets
	offsets[2] = value
	SOUL_GRADIENT_BAR.gradient.offsets = offsets


func _on_button_pressed():
	if puntos > 0.3:
		puntos -= 0.05
	subir(puntos)
