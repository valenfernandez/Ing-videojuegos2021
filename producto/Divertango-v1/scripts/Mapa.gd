extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_botonteatro1_pressed(): 
	Global.set_nivel(1);
	if get_tree().change_scene("res://scenes/Musicos.tscn") != OK:
		print ("Error")


func _on_botonteatro2_pressed():
	Global.set_nivel(2);
	if get_tree().change_scene("res://scenes/Musicos.tscn") != OK:
		print ("Error")


func _on_botonteatro3_pressed():
	Global.set_nivel(3);
	if get_tree().change_scene("res://scenes/Musicos.tscn") != OK:
		print ("Error")
