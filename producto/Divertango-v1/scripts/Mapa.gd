extends Node2D


func _ready():
	
	$points_t1.text = str(Global.puntos_teatro1)
	$points_t2.text = str(Global.puntos_teatro2)
	$points_t3.text = str(Global.puntos_teatro3)
	
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


func _on_Node2D_tree_entered():
	$points_t1.text = str(Global.puntos_teatro1)
	$points_t2.text = str(Global.puntos_teatro2)
	$points_t3.text = str(Global.puntos_teatro3)
