extends Node2D

var tmusico1 = null
var tmusico2 = null
var tmusico3 = null

var tutorial_visible = false

func _ready():
	var teatro = DiccionarioNiveles.nivel_actual
	$AnimatedSprite.frame = teatro - 1
	if (teatro == 1):
		$Sprite.texture = load("res://assets/img/musicostext1.png")
		tmusico1 = load("res://assets/img/musico1.png")
		tmusico2 = load("res://assets/img/musico2.png")
		tmusico3 = load("res://assets/img/musico7.png")
	elif(teatro == 2):
		$Sprite.texture = load("res://assets/img/musicostext2.png")
		tmusico1 = load("res://assets/img/musico4.png")
		tmusico2 = load("res://assets/img/musico5.png")
		tmusico3 = load("res://assets/img/musico6.png")
	elif(teatro == 3):
		$Sprite.texture = load("res://assets/img/musicostext3.png")
		tmusico1 = load("res://assets/img/musico3.png")
		tmusico2 = load("res://assets/img/musico8.png")
		tmusico3 = load("res://assets/img/musico9.png")
	$musico1.set_normal_texture(tmusico1)
	$musico2.set_normal_texture(tmusico2)
	$musico3.set_normal_texture(tmusico3)
	$FondoTutorial.hide()
	$labelTutorial.hide()
	
	
	var partidas_ant = Global.partidas
	for enc in partidas_ant:
		if(enc != null && enc.teatro == teatro):
			if (enc.musico == 1):
				$LabelPuntaje1.text = str(enc.highscore)
				$ultPuntaje1.text = str(enc.score)
			elif (enc.musico == 2):
				$LabelPuntaje2.text = str(enc.highscore)
				$ultPuntaje2.text = str(enc.score)
			elif (enc.musico == 3):
				$LabelPuntaje3.text = str(enc.highscore)
				$ultPuntaje3.text = str(enc.score)
	

func _on_musico1_pressed():
	DiccionarioNiveles.set_musico(1)
	Global.textura_musico = tmusico1
	$SonidoClick.play()
	yield($SonidoClick, "finished")
	if get_tree().change_scene("res://scenes/Ritmico.tscn") != OK:
		print ("Error")


func _on_musico2_pressed():
	DiccionarioNiveles.set_musico(2)
	Global.textura_musico = tmusico2
	$SonidoClick.play()
	yield($SonidoClick, "finished")
	if get_tree().change_scene("res://scenes/Ritmico.tscn") != OK:
		print ("Error")


func _on_musico3_pressed():
	DiccionarioNiveles.set_musico(3)
	Global.textura_musico = tmusico3
	$SonidoClick.play()
	yield($SonidoClick, "finished")
	if get_tree().change_scene("res://scenes/Ritmico.tscn") != OK:
		print ("Error")


func _on_botonVolver_pressed():
	$SonidoClick.play()
	yield($SonidoClick, "finished")
	if get_tree().change_scene("res://scenes/Mapa.tscn") != OK:
		print ("Error")


func _on_botonTutorial_pressed():
	$SonidoClick.play()
	yield($SonidoClick, "finished")
	if tutorial_visible == false:
		$FondoTutorial.show()
		$labelTutorial.show()
		tutorial_visible = true
	else:
		$labelTutorial.hide()
		$FondoTutorial.hide()
		tutorial_visible = false
