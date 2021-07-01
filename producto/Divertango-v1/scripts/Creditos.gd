extends Node2D


func _ready():
	pass # Replace with function body.


func _on_botonVolver_pressed():
	$SonidoClick.play()
	yield($SonidoClick, "finished")
	if get_tree().change_scene("res://scenes/Menu.tscn") != OK:
		print ("Error")
