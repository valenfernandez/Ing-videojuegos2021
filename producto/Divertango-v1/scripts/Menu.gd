extends Node2D


func _ready():
	$HSlider.set_value(10)

func _on_botonComenzar_pressed():
	$SonidoClick.play()
	yield($SonidoClick, "finished")
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 
								linear2db($HSlider.value))
	if get_tree().change_scene("res://scenes/Mapa.tscn") != OK:
		print ("Error")

func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),
								linear2db(value))

func _on_botonCreditos_pressed():
	$SonidoClick.play()
	yield($SonidoClick, "finished")
	if get_tree().change_scene("res://scenes/Creditos.tscn") != OK:
		print ("Error")
