extends Node2D

func _ready():
	var teatro = DiccionarioNiveles.nivel_actual
	$AnimatedSprite.frame = teatro - 1

func _on_musico1_pressed():
	DiccionarioNiveles.set_musico(1)
	if get_tree().change_scene("res://scenes/Ritmico.tscn") != OK:
		print ("Error")


func _on_musico2_pressed():
	DiccionarioNiveles.set_musico(2)
	if get_tree().change_scene("res://scenes/Ritmico.tscn") != OK:
		print ("Error")


func _on_musico3_pressed():
	DiccionarioNiveles.set_musico(3)
	if get_tree().change_scene("res://scenes/Ritmico.tscn") != OK:
		print ("Error")
