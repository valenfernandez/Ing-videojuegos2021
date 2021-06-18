extends Node2D

var perfect = 0
var good = 0
var ok = 0
var notas_trampa = 0    # contador de notas trampa presionadas
var bandoneon = 0
var score = 0
var score_ganador = 100

var level_1_passed = false
var level_2_passed = false
var level_3_passed = false

var puntos_teatro1 = 0 # sumo los max_score que tengo en la persistencia
var puntos_teatro2 = 0
var puntos_teatro3 = 0

func encuentro_ganado():	
	# aviso que gano el nivel DiccionarioNiveles.nivel_actual y  DiccionarioNiveles.musico_actual 
	# guardo su puntaje y lo comparo con el mas alto (otro de la persistencia)
	# reemplazo el mas alto el la suma de puntos de ese nivel:
	#### puntos teatro1 = max_nivel1musico1 + max_nivel2musico2 + max_nivel3musico3
	
	pass 
	

func set_score(num):
	score = num

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

