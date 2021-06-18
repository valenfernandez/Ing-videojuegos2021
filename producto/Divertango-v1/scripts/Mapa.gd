extends Node2D

var level_2_score = 0
var level_3_score = 0

func _ready():
	if(Global.level_1_passed == true):
		$botonteatro2.disabled = false
	if(Global.level_2_passed == true):
		$botonteatro3.disabled = false


func _on_botonteatro1_pressed(): 
	DiccionarioNiveles.set_nivel(1);
	if get_tree().change_scene("res://scenes/Musicos.tscn") != OK:
		print ("Error")


func _on_botonteatro2_pressed():
	DiccionarioNiveles.set_nivel(2);
	if get_tree().change_scene("res://scenes/Musicos.tscn") != OK:
		print ("Error")


func _on_botonteatro3_pressed():
	DiccionarioNiveles.set_nivel(3);
	if get_tree().change_scene("res://scenes/Musicos.tscn") != OK:
		print ("Error")


