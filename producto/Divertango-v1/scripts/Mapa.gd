extends Node2D

var tutorial_visible = false

# Cada vez que cambiamos a esta escena, se ejecutará este ready, ya que entrará al árbol de nodos.
func _ready():
	$points_t1.text = str(Global.puntos_teatro1)
	$points_t2.text = str(Global.puntos_teatro2)
	$points_t3.text = str(Global.puntos_teatro3)
	if(Global.level_1_passed == true):
		$botonTeatro2.disabled = false
	if(Global.level_2_passed == true):
		$botonTeatro3.disabled = false
	$FondoTutorial.hide()
	$labelTutorial.hide()
	

func _on_botonTeatro1_pressed(): 
	DiccionarioNiveles.set_nivel(1);
	$SonidoClick.play()
	yield($SonidoClick, "finished")
	if get_tree().change_scene("res://scenes/Musicos.tscn") != OK:
		print("Error")


func _on_botonTeatro2_pressed():
	DiccionarioNiveles.set_nivel(2);
	$SonidoClick.play()
	yield($SonidoClick, "finished")
	if get_tree().change_scene("res://scenes/Musicos.tscn") != OK:
		print ("Error")


func _on_botonTeatro3_pressed():
	DiccionarioNiveles.set_nivel(3);
	$SonidoClick.play()
	yield($SonidoClick, "finished")
	if get_tree().change_scene("res://scenes/Musicos.tscn") != OK:
		print ("Error")


func _on_botonVolver_pressed():
	$SonidoClick.play()
	yield($SonidoClick, "finished")
	if get_tree().change_scene("res://scenes/Menu.tscn") != OK:
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
