extends Node2D


func _ready():
	pass


func _on_botonAvanzar_pressed():
	$SonidoClick.play()
	yield($SonidoClick, "finished")
	if get_tree().change_scene("res://scenes/Menu.tscn") != OK:
		print("Error")
