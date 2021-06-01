extends Node2D


var perfect_area = false
var good_area = false
var okay_area = false
var current_note =null

var score = 0

var great = 0
var good = 0
var okay = 0
var missed = 0

var bpm = 115

var song_position = 0.0
var song_position_in_beats = 0
var last_spawned_beat = 0
var sec_per_beat = 60.0 / bpm

var spawn_1_beat = 0
var spawn_2_beat = 0
var spawn_3_beat = 1
var spawn_4_beat = 0

var lane = 0
var rand = 0
var note = load("res://scenes/Notas_Musicales.tscn")
var instance
#var current note


func _ready():
	randomize()
	$Conductor.play_with_beat_offset(8)


func _input(event):
	if event.is_action("escape"):
		if get_tree().change_scene("res://scenes/Menu.tscn") != OK:
			print ("Error cambiando escena a Menu")


func _on_Conductor_measure(position):
	if position == 1:
		_spawn_notes(spawn_1_beat)
	elif position == 2:
		_spawn_notes(spawn_2_beat)
	elif position == 3:
		_spawn_notes(spawn_3_beat)
	elif position == 4:
		_spawn_notes(spawn_4_beat)

func _on_Conductor_beat(position):
	song_position_in_beats = position
	if song_position_in_beats > 36:
		spawn_1_beat = 1
		spawn_2_beat = 1
		spawn_3_beat = 1
		spawn_4_beat = 1
	if song_position_in_beats > 98:
		spawn_1_beat = 2
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 0
	if song_position_in_beats > 132:
		spawn_1_beat = 0
		spawn_2_beat = 2
		spawn_3_beat = 0
		spawn_4_beat = 2
	if song_position_in_beats > 162:
		spawn_1_beat = 2
		spawn_2_beat = 2
		spawn_3_beat = 1
		spawn_4_beat = 1
	if song_position_in_beats > 194:
		spawn_1_beat = 2
		spawn_2_beat = 2
		spawn_3_beat = 1
		spawn_4_beat = 2
	if song_position_in_beats > 228:
		spawn_1_beat = 0
		spawn_2_beat = 2
		spawn_3_beat = 1
		spawn_4_beat = 2
	if song_position_in_beats > 258:
		spawn_1_beat = 1
		spawn_2_beat = 2
		spawn_3_beat = 1
		spawn_4_beat = 2
	if song_position_in_beats > 288:
		spawn_1_beat = 0
		spawn_2_beat = 2
		spawn_3_beat = 0
		spawn_4_beat = 2
	if song_position_in_beats > 322:
		spawn_1_beat = 3
		spawn_2_beat = 2
		spawn_3_beat = 2
		spawn_4_beat = 1
	if song_position_in_beats > 388:
		spawn_1_beat = 1
		spawn_2_beat = 0
		spawn_3_beat = 0
		spawn_4_beat = 0
	if song_position_in_beats > 396:
		spawn_1_beat = 0
		spawn_2_beat = 0
		spawn_3_beat = 0
		spawn_4_beat = 0
	#if song_position_in_beats > 404:
		#parte que maneja la puntuacion, ver bien.
		#Global.set_score(score)
		#Global.combo = max_combo
		#Global.great = great
		#Global.good = good
		#Global.okay = okay
		#Global.missed = missed
		
		
		#pantalla de fin
		#if get_tree().change_scene("res://Scenes/End.tscn") != OK:
		#	print ("Error changing scene to End")



func _spawn_notes(to_spawn):
	if to_spawn > 0:
		lane = randi() % 4
		instance = note.instance()
		instance.initialize(lane)
		add_child(instance)
	if to_spawn > 1:
		while rand == lane:
			rand = randi() % 4
		lane = rand
		instance = note.instance()
		instance.initialize(lane)
		add_child(instance)
	# current_note = intance
	# podemos hacer que aparezcan tres notas a la vez, por ahi es muy complicado para jugar.
		

func check_collision_perfect(area):
	#funcion que devuelve si la nota esta colisionando area perfect.
	# if area.is_in_group("note"):
	# que nota colisiona con esta area?
	perfect_area = true
	return 
	
func check_collision_good(area):
	#funcion que devuelve si la nota esta colisionando area good.
	good_area= true
	return 
	
func check_collision_okay(area):
	#funcion que devuelve si la nota esta colisionando area ok.
	okay_area = true
	return 


func check_player_action(): 
	#cuando se apreta un boton chequea si hay colision y
	# dependiendo de que colision hay da puntos (llama a increment score)
	#if boton apretado 
	if current_note != null:
		if perfect_area:
			increment_score(3)
			current_note.destroy(3)
		elif good_area:
			increment_score(2)
			current_note.destroy(2)
		elif okay_area:
			increment_score(1)
			current_note.destroy(1)
		_reset()
	else:
		increment_score(-1) #por ahi se puede añadir un aviso (cartel o label de "le erraste") 
	
func _reset():
	current_note = null
	perfect_area = false
	good_area = false
	okay_area = false

func increment_score(by): 
	if by == 3:
		great += 1
	elif by == 2:
		good += 1
	elif by == 1:
		okay += 1
	else:
		missed += 1
	score += by
	$score.text = str(score)



func _on_blanca_pressed():
	# nombre_boton_apretado= "blanca"
	# chequear colision de ese tipo de nota/carril con una de las areas. 
	
	pass


func _on_negra_pressed():
	pass # Replace with function body.


func _on_semicorchea_pressed():
	pass # Replace with function body.


func _on_corchea_pressed():
	pass # Replace with function body.


func area_exited(area): # la nota paso y no se apreto ningun boton.
	increment_score(-2)
	current_note.destroy(-1)
	pass # Replace with function body.
