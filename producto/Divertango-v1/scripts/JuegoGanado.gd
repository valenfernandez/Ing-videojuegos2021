extends Node2D


func _ready():
	pass # Replace with function body.


func _on_botonAvanzar_pressed():
	$SonidoClick.play()
	yield($SonidoClick, "finished")
	if get_tree().change_scene("res://scenes/Creditos.tscn") != OK:
		print ("Error")
