extends Node2D

func _ready():
	var teatro = DiccionarioNiveles.nivel_actual
	$AnimatedSprite.frame = teatro - 1
	if (teatro == 1):
		$musico1.set_normal_texture(load("res://assets/img/musico1.png"))
		$musico2.set_normal_texture(load("res://assets/img/musico2.png"))
		$musico3.set_normal_texture(load("res://assets/img/musico7.png"))
	elif(teatro == 2):
		$musico1.set_normal_texture(load("res://assets/img/musico4.png"))
		$musico2.set_normal_texture(load("res://assets/img/musico5.png"))
		$musico3.set_normal_texture(load("res://assets/img/musico6.png"))
	elif(teatro == 3):
		$musico1.set_normal_texture(load("res://assets/img/musico3.png"))
		$musico2.set_normal_texture(load("res://assets/img/musico8.png"))
		$musico3.set_normal_texture(load("res://assets/img/musico9.png"))
	var partidas_ant = Global.partidas
	for enc in partidas_ant:
		if(enc != null && enc.teatro == teatro):
			if (enc.musico == 1):
				$LabelPuntaje1.text = str(enc.highscore)
			elif (enc.musico == 2):
				$LabelPuntaje2.text = str(enc.highscore)
			elif (enc.musico == 3):
				$LabelPuntaje3.text = str(enc.highscore)
	
	

func _on_musico1_pressed():
	DiccionarioNiveles.set_musico(1)
	$AudioStreamPlayer.play()
	yield($AudioStreamPlayer, "finished")
	if get_tree().change_scene("res://scenes/Ritmico.tscn") != OK:
		print ("Error")


func _on_musico2_pressed():
	DiccionarioNiveles.set_musico(2)
	$AudioStreamPlayer.play()
	yield($AudioStreamPlayer, "finished")
	if get_tree().change_scene("res://scenes/Ritmico.tscn") != OK:
		print ("Error")


func _on_musico3_pressed():
	DiccionarioNiveles.set_musico(3)
	$AudioStreamPlayer.play()
	yield($AudioStreamPlayer, "finished")
	if get_tree().change_scene("res://scenes/Ritmico.tscn") != OK:
		print ("Error")
