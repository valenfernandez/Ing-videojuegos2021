extends Node2D


func _ready():
	pass


func _on_TextureButton_pressed():
	if get_tree().change_scene("res://scenes/Menu.tscn") != OK:
		print("Error")
