extends Node2D



func _ready():
	$bien_num.text = str(Global.good)
	$ok_num.text = str(Global.ok)
	$perfect_num.text = str(Global.perfect)
	$missed_num.text = str(Global.missed)
	$score_num.text = str(Global.score)




func _on_volver_jugar_pressed():
	if get_tree().change_scene("res://scenes/Ritmico.tscn") != OK:
		print ("Error")


func _on_a_menu_pressed():
	if get_tree().change_scene("res://scenes/Menu.tscn") != OK:
		print ("Error")
