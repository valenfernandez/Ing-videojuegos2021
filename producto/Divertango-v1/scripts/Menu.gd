extends Node2D


func _ready():
	pass 

func _on_BotonComenzar_pressed():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 
								linear2db($HSlider.value))
	if get_tree().change_scene("res://scenes/Mapa.tscn") != OK:
		print ("Error")


func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),
								linear2db(value))
