extends Node2D


var area_points = 0 
var area_blancas = false
var area_negras = false
var area_corchea = false
var area_semi = false
var current_note = null
var bandoneon_activo = false
var num_lanes = 4

var score = 0
var perfect = 0
var good = 0
var okay = 0
var bandoneon = 0
var missed = 0

var bpm = 160 #default

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


func _ready():
	randomize()
	$boton_bandoneon.hide()
	cargar_nivel()
	$Conductor.play_with_beat_offset(8)
	

func cargar_nivel():
	var diccionario = DiccionarioNiveles.getDiccionario()
	bpm = diccionario["bpm"]
	$Conductor.bpm =  diccionario["bpm"]
	num_lanes = diccionario["lanes"]



func _on_Conductor_measure(position):
	if position == 1:
		_spawn_notes(spawn_1_beat)
	elif position == 2:
		_spawn_notes(spawn_2_beat)
	elif position == 3:
		_spawn_notes(spawn_3_beat)
	elif position == 4:
		_spawn_notes(spawn_4_beat)
	
		
func bandoneon_activar(prob):
	var activo = false
	var num = randi() % 100
	if( num < prob):
		$boton_bandoneon.show()
		$boton_bandoneon.disabled = false
		activo = true
		print(num)
	return activo
	
func bandoneon_desactivar():
	$boton_bandoneon.disabled = true
	$boton_bandoneon.hide()
	return false
	
#segun nivel y musico 
func _on_Conductor_beat(position):
	song_position_in_beats = position
	if song_position_in_beats > 36:
		spawn_1_beat = 0
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 0
	if song_position_in_beats == 36:
		if(! bandoneon_activo):
			bandoneon_activo = bandoneon_activar(20)
	if song_position_in_beats == 46:
		if (bandoneon_activo):
			bandoneon_activo = bandoneon_desactivar()
	if song_position_in_beats > 98:
		spawn_1_beat = 0
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 0
	if song_position_in_beats == 98:
		if(! bandoneon_activo):
			bandoneon_activo = bandoneon_activar(100)
	if song_position_in_beats == 108:
		if (bandoneon_activo):
			bandoneon_activo = bandoneon_desactivar()
	if song_position_in_beats > 132:
		spawn_1_beat = 0
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 0
	if song_position_in_beats == 132:
		if(! bandoneon_activo):
			bandoneon_activo = bandoneon_activar(80)
	if song_position_in_beats == 142:
		if (bandoneon_activo):
			bandoneon_activo = bandoneon_desactivar()
	if song_position_in_beats > 162:
		spawn_1_beat = 0
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 0
	if song_position_in_beats == 162:
		if(! bandoneon_activo):
			bandoneon_activo = bandoneon_activar(70)
	if song_position_in_beats == 172:
		if (bandoneon_activo):
			bandoneon_activo = bandoneon_desactivar()
	if song_position_in_beats > 190:
		spawn_1_beat = 0
		spawn_2_beat = 0
		spawn_3_beat = 0
		spawn_4_beat = 0
	if song_position_in_beats > 228:
		spawn_1_beat = 0
		spawn_2_beat = 0
		spawn_3_beat = 0
		spawn_4_beat = 0
	if song_position_in_beats > 238:
		Global.set_score(score)
		Global.set_perfect(perfect)
		Global.set_ok(okay)
		Global.set_bandoneon(bandoneon)
		Global.set_good(good)
		Global.set_missed(missed-perfect)  # REVISAR PERDIDOS DA UN NUM INCORRECTO!!!!!!!!!!!!!!!!!!
		if get_tree().change_scene("res://scenes/Puntaje.tscn") != OK:
			print ("Error")


func _spawn_notes(to_spawn):
	if to_spawn > 0:
		lane = randi() % num_lanes
		print(current_note)
		instance = note.instance()
		print(current_note)
		instance.initialize(lane)
		print(current_note)
		add_child(instance)
	if to_spawn > 1:
		while rand == lane:
			rand = randi() % 4
		lane = rand
		instance = note.instance()
		instance.initialize(lane)
		add_child(instance)
		


func _on_blanca_pressed():
	check_player_action("blanca")

func _on_negra_pressed():
	check_player_action("negra")

func _on_semicorchea_pressed():
	check_player_action("semi")

func _on_corchea_pressed():
	check_player_action("corchea")


func check_player_action(button): 
#cuando se apreta un boton chequea si hay colision y dependiendo de que colision hay da puntos (llama a increment score)
	if ((current_note != null) && correct_button(button)): #aca podemos devolver en vez de true o false los area points
		print(current_note)
		increment_score(area_points)
		current_note.destroy(area_points)
		_reset()
	else:
		increment_score(-1) #por ahi se puede añadir un aviso (cartel o label de "le erraste") 

func correct_button(button):
	var correct = false
	if(button == "blanca" && area_blancas == true):
		correct = true
	elif(button == "negra" && area_negras == true):
		correct = true
	elif(button == "semi" && area_semi == true):
		correct = true
	elif(button == "corchea" && area_corchea == true):
		correct = true
	else:
		correct=false
	return correct
	
func _reset():
	area_blancas = false
	area_negras = false
	area_corchea = false
	area_semi = false
	area_points = 0
	current_note = null


func increment_score(by): 
	if by == 3:
		perfect += 1
	elif by == 2:
		good += 1
	elif by == 1:
		okay += 1
	elif by == 10:
		bandoneon += 1
	elif by <= 0:
		missed += 1
	score += by
	$score.text = str(score)


func area_exited(area): # la nota paso y no se apreto ningun boton.
	increment_score(-1)
	current_note = null


func _on_AreaBlancaPerfect_area_entered(area): #esa area que viene de parametro es el area que colisiona
	# area.set_puntos(3)
	area_blancas = true
	area_points = 3


func _on_AreaBlancaGood_area_entered(area):
	area_blancas = true
	area_points = 2


func _on_AreaBlancaOK_area_entered(area):
	area_blancas = true
	area_points = 1
	current_note = area


func _on_AreaNegraPerfect_area_entered(area):
	area_negras = true
	area_points = 3


func _on_AreaNegraGood_area_entered(area):
	area_negras = true
	area_points = 2


func _on_AreaNegraOK_area_entered(area):
	area_negras = true
	area_points = 1
	current_note = area


func _on_AreaCorcheaPerfect_area_entered(area):
	area_corchea = true
	area_points = 3


func _on_AreaCorcheaGood_area_entered(area):
	area_corchea = true
	area_points = 2


func _on_AreaCorcheaOK_area_entered(area):
	area_corchea = true
	area_points = 1
	current_note = area


func _on_AreaSemiCorcheaPerfect2_area_entered(area):
	area_semi = true
	area_points = 3


func _on_AreaSemiCorcheaGood2_area_entered(area):
	area_semi = true
	area_points = 2


func _on_AreaSemiCorcheaOK_area_entered(area):
	area_semi = true
	area_points = 1
	current_note = area


func _on_boton_bandoneon_pressed():
	increment_score(10)
	$boton_bandoneon.disabled = true
	$boton_bandoneon.hide()
	bandoneon_activo = false
