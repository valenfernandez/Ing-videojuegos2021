extends Node2D


func _ready():
	$bien_num.text = str(Global.good)
	$ok_num.text = str(Global.ok)
	$perfect_num.text = str(Global.perfect)
	$score_num.text = str(Global.score)
	$trampa_num.text = str(Global.notas_trampa)
	$bandoneon_num.text = str(Global.bandoneon)
	if(Global.encuentro_ganado == true):
		$AnimatedSprite.frame = 0
	else:
		$AnimatedSprite.frame = 1


func _on_volver_jugar_pressed():
	$SonidoClick.play()
	yield($SonidoClick, "finished")
	if get_tree().change_scene("res://scenes/Ritmico.tscn") != OK:
		print ("Error")


func _on_a_menu_pressed():
	$SonidoClick.play()
	yield($SonidoClick, "finished")
	if(Global.encuentro_ganado == true
	  and DiccionarioNiveles.nivel_actual == 3
	  and Global.level_3_passed == true): # Ganamos el juego
		if get_tree().change_scene("res://scenes/JuegoGanado.tscn") != OK:
			print ("Error")
	else:
		if get_tree().change_scene("res://scenes/Menu.tscn") != OK:
			print ("Error")
