extends Node2D


var area_points = 0 
var area_blancas = false
var area_negras = false
var area_corchea = false
var area_semi = false
var trampa_blanca = false
var trampa_negra = false
var trampa_corchea = false
var trampa_semi = false
var notas_perdidas = 0

var current_note = null
var bandoneon_activo = false
var enabled_lanes = 4 # carriles habilitados para que se spawneen notas
var spawn_multiplier = 1 
var bandoneon_prob = [100,100,100,100]
var trap_prob = 0

var score = 0
var perfect = 0   # contadores de notas acertadas
var good = 0
var okay = 0
var bandoneon = 0 # contador de tocadas de bandoneon
var notas_trampa = 0    # contador de notas trampa presionadas

var bpm = 160 # 'beats per minute' de la canción (por default 160)

var song_position = 0.0
var song_position_in_beats = 0
var last_spawned_beat = 0
var sec_per_beat = 60.0 / bpm 

# Estas 4 variables representan la cantidad de notas que aparecerán en cada pulso de la canción.
# Se van tomando de a 4 pulsos ya que se definen compases de 4 tiempos (4/4) (measures=4)
# Estos valores se van cambiando a medida que avancemos en la cancion (ver '_on_Conductor_beat()')
var spawn_1_beat = 0
var spawn_2_beat = 0
var spawn_3_beat = 1 # en este caso, en los pulsos 3,7,11 ... aparecerá un nota (1 nota cada 4 pulsos)
var spawn_4_beat = 0

var lane = 0
var rand = 0
var note = load("res://scenes/Notas_Musicales.tscn")
var trap_note = load("res://scenes/Notas_Trampa.tscn")
var instance


func _ready():
	randomize()
	$musico.texture = Global.textura_musico
	$boton_bandoneon.hide()
	cargar_nivel()
	$Conductor.play_with_beat_offset(8)
	

func cargar_nivel():
	var nivel = DiccionarioNiveles.get_nivel()
	$Conductor.stream = load(nivel.cancion)
	$Conductor.bpm = nivel.bpm
	bpm = nivel.bpm
	enabled_lanes = nivel.lanes
	spawn_multiplier = nivel.spawn_multiplier
	bandoneon_prob = nivel.bandoneon_prob
	trap_prob = nivel.trap_prob  

# El Conductor nos va diciendo en qué tiempo del compás estamos en cada momento (1, 2, 3 o 4).
# En base a eso, spawnearemos tantas notas como indique 'spawn_X_beat'.
func _on_Conductor_measure(position):
	if position == 1:
		_spawn_notes(spawn_1_beat)
	elif position == 2:
		_spawn_notes(spawn_2_beat)
	elif position == 3:
		var aux = randi() % 100
		if (aux < trap_prob):
			_spawn_trap_note()
		else:
			_spawn_notes(spawn_3_beat)
	elif position == 4:
		_spawn_notes(spawn_4_beat)
	
		
		
		
func terminar_juego():
	Global.set_score(score)
	Global.set_perfect(perfect)
	Global.set_ok(okay)
	Global.set_bandoneon(bandoneon)
	Global.set_good(good)
	Global.set_trampas(notas_trampa)
	if(notas_perdidas < 5 && score > Global.score_ganador):
		Global.set_encuentro_ganado(true)
	else:
		Global.set_encuentro_ganado(false)
	Global.actualizar_puntaje_teatros()
	Global.persistir_partida()
	if get_tree().change_scene("res://scenes/Puntaje.tscn") != OK:
		print ("Error")
	
	
func bandoneon_activar(prob):
	var activo = false
	var num = randi() % 100
	if( num < prob):
		$boton_bandoneon.show()
		$boton_bandoneon.disabled = false
		activo = true
	return activo
	
func bandoneon_desactivar():
	$boton_bandoneon.disabled = true
	$boton_bandoneon.hide()
	return false
	
	
#segun nivel y musico
# El Conductor nos va diciendo en qué posicion (beat/pulso) de la cancion estamos.
# En base a eso, definimos intervalos donde se spawnearán mas o menos notas por pulso.
# La cantidad depende del tiempo (1, 2, 3 o 4) en el que cae/esté el pulso,
# entonces vamos modificando la cantidad de notas a spawnearse segun el tiempo.
func _on_Conductor_beat(position):
	song_position_in_beats = position
	if song_position_in_beats > 36:
		spawn_1_beat = 0
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 0
	if song_position_in_beats == 36:
		if(! bandoneon_activo):
			bandoneon_activo = bandoneon_activar(bandoneon_prob[0])
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
			bandoneon_activo = bandoneon_activar(bandoneon_prob[1])
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
			bandoneon_activo = bandoneon_activar(bandoneon_prob[2])
	if song_position_in_beats == 142:
		if (bandoneon_activo):
			bandoneon_activo = bandoneon_desactivar()
	if song_position_in_beats > 162:
		spawn_1_beat = 0
		spawn_2_beat = 0
		spawn_3_beat = 1 * spawn_multiplier
		spawn_4_beat = 0
	if song_position_in_beats == 162:
		if(! bandoneon_activo):
			bandoneon_activo = bandoneon_activar(bandoneon_prob[3])
	if song_position_in_beats == 172:
		if (bandoneon_activo):
			bandoneon_activo = bandoneon_desactivar()
	if song_position_in_beats > 190:
		spawn_1_beat = 0
		spawn_2_beat = 1
		spawn_3_beat = spawn_multiplier
		spawn_4_beat = 0
	if song_position_in_beats > 200:
		spawn_1_beat = 0
		spawn_2_beat = 0
		spawn_3_beat = 0
		spawn_4_beat = 0
	if song_position_in_beats > 230:
		terminar_juego()

# Cada tipo de nota aparece en un determinado carril, entonces obtenemos aleatoriamente
# un carril en base al número de carriles que tengamos habilitados (1, 2, 3 o 4),
# e instanciamos la nota de dicho carril.
# Por como pusimos los ifs, como mucho se pueden spawnear 2 notas a la vez por pulso.
# ---
# Hay que tener cuidado con 'num_lanes', ya que si fuera = 1 (1 carril solo habilitado)
# y 'to_spawn' nos llega con >= 2, el while que tenemos sería infinito.
# Lo ideal sería que siempre 'to_spawn' <= 'num_lanes'
# ---
func _spawn_notes(to_spawn):
	if to_spawn > 0:
		lane = randi() % enabled_lanes
		instance = note.instance()
		instance.initialize(lane)
		add_child(instance)
	if to_spawn > 1 && enabled_lanes >= to_spawn:
		while rand == lane: # para evitar que en un mismo momento (pulso) aparezcan 2 notas en el mismo carril
			rand = randi()  % enabled_lanes 
		lane = rand
		instance = note.instance()
		instance.initialize(lane)
		add_child(instance)
		
func _spawn_trap_note():
	instance = trap_note.instance()
	instance.initialize(enabled_lanes)
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
		increment_score(area_points)
		current_note.hitted()
		current_note.destroy(area_points)
		_reset()
	else:
		if ((current_note != null) && trap_pressed(button)): #se apreto una nota trampa
			increment_score(-10)
			current_note.hitted()
			current_note.destroy()
		else:
			increment_score(-10) #apreto un boton cuando no habia nada
			

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
	
func trap_pressed(button):
	var traped = false
	if(button == "blanca" && trampa_blanca == true):
		traped = true
	elif(button == "negra" && trampa_negra == true):
		traped = true
	elif(button == "semi" && trampa_semi == true):
		traped = true
	elif(button == "corchea" && trampa_corchea == true):
		traped = true
	else:
		traped=false
	return traped 
	
	
func _reset():
	area_blancas = false
	area_negras = false
	area_corchea = false
	area_semi = false
	trampa_blanca = false
	trampa_negra = false
	trampa_corchea = false
	trampa_semi = false
	area_points = 0
	current_note = null


func increment_score(by): 
	if by == 20:
		perfect += 1
	elif by == 15:
		good += 1
	elif by == 10:
		okay += 1
	elif by == 30:
		bandoneon += 1
	score += by
	if(score < 0):
		score = 0
	$score.text = str(score)


func area_exited(area): # la nota paso y no se apreto ningun boton.
	if(area.get_class() == "Notas_Musicales"):
		if (area.hitted == false) :
			notas_perdidas += 1
			$perdidas.text = str(notas_perdidas)
			$AudioStreamPlayer.play()
			yield($AudioStreamPlayer, "finished")
			if(notas_perdidas >= 5):
				terminar_juego()
	current_note = null

func _on_AreaBlancaPerfect_area_entered(area): #esa area que viene de parametro es el area que colisiona
	if(area.get_class() == "Notas_Musicales"):
		area_blancas = true
		area_points = 20
	elif(area.get_class() == "Notas_Trampa"):
		trampa_blanca= true


func _on_AreaBlancaGood_area_entered(area):
	if(area.get_class() == "Notas_Musicales"):
		area_blancas = true
		area_points = 15
	elif(area.get_class() == "Notas_Trampa"):
		trampa_blanca= true


func _on_AreaBlancaOK_area_entered(area):
	if(area.get_class() == "Notas_Musicales"):
		current_note = area
		area_blancas = true
		area_points = 10
	elif(area.get_class() == "Notas_Trampa"):
		current_note = area
		trampa_blanca= true
	


func _on_AreaNegraPerfect_area_entered(area):
	if(area.get_class() == "Notas_Musicales"):
		area_negras = true
		area_points = 20
	elif(area.get_class() == "Notas_Trampa"):
		trampa_negra= true


func _on_AreaNegraGood_area_entered(area):
	if(area.get_class() == "Notas_Musicales"):
		area_negras = true
		area_points = 15
	elif(area.get_class() == "Notas_Trampa"):
		trampa_negra= true


func _on_AreaNegraOK_area_entered(area):
	if(area.get_class() == "Notas_Musicales"):
		current_note = area
		area_negras = true
		area_points = 10
	elif(area.get_class() == "Notas_Trampa"):
		current_note = area
		trampa_negra= true
	


func _on_AreaCorcheaPerfect_area_entered(area):
	if(area.get_class() == "Notas_Musicales"):
		area_corchea = true
		area_points = 20
	elif(area.get_class() == "Notas_Trampa"):
		trampa_corchea= true
	


func _on_AreaCorcheaGood_area_entered(area):
	if(area.get_class() == "Notas_Musicales"):
		area_corchea = true
		area_points = 15
	elif(area.get_class() == "Notas_Trampa"):
		trampa_corchea= true


func _on_AreaCorcheaOK_area_entered(area):
	if(area.get_class() == "Notas_Musicales"):
		current_note = area
		area_corchea = true
		area_points = 10
	elif(area.get_class() == "Notas_Trampa"):
		current_note = area
		trampa_corchea= true
	


func _on_AreaSemiCorcheaPerfect2_area_entered(area):
	if(area.get_class() == "Notas_Musicales"):
		area_semi = true
		area_points = 20
	elif(area.get_class() == "Notas_Trampa"):
		trampa_semi= true
	

func _on_AreaSemiCorcheaGood2_area_entered(area):
	if(area.get_class() == "Notas_Musicales"):
		area_semi = true
		area_points = 15
	elif(area.get_class() == "Notas_Trampa"):
		trampa_semi= true


func _on_AreaSemiCorcheaOK_area_entered(area):
	if(area.get_class() == "Notas_Musicales"):
		current_note = area
		area_semi = true
		area_points = 10
	elif(area.get_class() == "Notas_Trampa"):
		current_note = area
		trampa_semi= true
	


func _on_boton_bandoneon_pressed():
	increment_score(30)
	$boton_bandoneon.disabled = true
	$boton_bandoneon.hide()
	bandoneon_activo = false
