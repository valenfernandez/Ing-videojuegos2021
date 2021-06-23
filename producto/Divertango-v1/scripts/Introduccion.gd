extends Node2D


func _ready():
	pass


func _on_TextureButton_pressed():
	$AudioStreamPlayer.play()
	yield($AudioStreamPlayer, "finished")
	if get_tree().change_scene("res://scenes/Menu.tscn") != OK:
		print("Error")
