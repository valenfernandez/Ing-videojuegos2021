extends Node2D

var perfect = 0
var good = 0
var ok = 0
var notas_trampa = 0    # contador de notas trampa presionadas
var bandoneon = 0
var score = 0
var score_ganador = 100 # puntos que hay que alcanzar en un encuentro musical para ganarlo

var encuentro_ganado = false

var level_1_passed = false
var level_2_passed = false

var puntos_pasar_nivel1 = 100 # puntos totales del teatro 1 para considerarse pasado
var puntos_pasar_nivel2 = 100 # puntos totales del teatro 2 para considerarse pasado

var puntos_teatro1 = 0 # sumo los max_score que tengo en la persistencia
var puntos_teatro2 = 0
var puntos_teatro3 = 0

const SAVE_PATH = "res://saves.sav"

var partidas = []

var encuentro = {
	"teatro":0,
	"musico":0,
	"score":0,
	"highscore":0
}

func _ready():
	cargar_partidas()
	iniciar_puntaje()
	if(puntos_teatro1 >= puntos_pasar_nivel1):
		level_1_passed = true
	if(puntos_teatro2 >= puntos_pasar_nivel2):
		level_2_passed = true
	
	
func cargar_partidas():
	var aux = []
	var save_game = File.new()
	if not save_game.file_exists(SAVE_PATH):
		return # Error! No hay archivo que cargar (cuando se haga la primera persistencia, se creará)
	save_game.open(SAVE_PATH, File.READ)
	while(!save_game.eof_reached()):
		aux.append(parse_json(save_game.get_line()))
	save_game.close()
	partidas = aux # para que la lista que conservamos en memoria, se actualice completamente.

func iniciar_puntaje():
	for enc in partidas:
		print(enc)
		print(partidas)
		if(enc != null):
			if (enc.teatro == 1):
				puntos_teatro1 += enc.highscore
			elif (enc.teatro == 2):
				puntos_teatro2 += enc.highscore
			elif (enc.teatro == 3):
				puntos_teatro3 += enc.highscore
		

func set_score(num):
	score = num
	encuentro.score = num
	encuentro.teatro = DiccionarioNiveles.nivel_actual
	encuentro.musico = DiccionarioNiveles.musico_actual
	cargar_partidas() # levantar lista de partidas de la persistencia
	var old_hs = get_highscore()
	if(score > old_hs):
		encuentro.highscore = score
	else:
		encuentro.highscore = old_hs
	delete_old_encounter() # borramos el encuentro con el puntaje anterior de la lista de partidas
	partidas.append(encuentro) # agregamos el encuentro con su puntaje actualizado

	
func get_highscore():
	var respuesta = 0
	var teatro = DiccionarioNiveles.nivel_actual
	var musico = DiccionarioNiveles.musico_actual
	for enc in partidas:
		if (enc != null && enc.teatro == teatro && enc.musico == musico):
			respuesta = enc.highscore
	return respuesta

func delete_old_encounter():
	var teatro = DiccionarioNiveles.nivel_actual
	var musico = DiccionarioNiveles.musico_actual
	var old_encounter = null
	for enc in partidas:
		if (enc != null && enc.teatro == teatro && enc.musico == musico):
			old_encounter= enc
	if(old_encounter!= null):
		partidas.erase(old_encounter)

func set_perfect(num):
	perfect = num
	
func set_good(num):
	good = num

func set_ok(num):
	ok = num

func set_bandoneon(num):
	bandoneon = num

func set_trampas(num):
	notas_trampa=num

func set_encuentro_ganado(ganado):
	encuentro_ganado = ganado;

# por como lo pensamos, si en un encuentro con un musico no superamos nuestro highscore,
# los puntos ganados no se sumarán al puntaje total del teatro
func actualizar_puntaje_teatros():
	var teatro = DiccionarioNiveles.nivel_actual
	var sum = 0
	for enc in partidas:
		if (enc != null && enc.teatro == teatro):
			sum += enc.highscore
	if(teatro == 1):
		puntos_teatro1 = sum
		if(puntos_teatro1 >= puntos_pasar_nivel1):
			level_1_passed = true
	elif(teatro == 2):
		puntos_teatro2 = sum
		if(puntos_teatro2 >= puntos_pasar_nivel2):
			level_2_passed = true
	elif(teatro == 3):
		puntos_teatro3 = sum
	

func persistir_partida():
	var save_game = File.new()
	save_game.open(SAVE_PATH, File.WRITE)
	for enc in partidas:
		if(enc != null):
			save_game.store_line(to_json(enc))
	save_game.close()
