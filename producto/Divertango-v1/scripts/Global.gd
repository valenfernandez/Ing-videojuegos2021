extends Node2D

var perfect = 0
var good = 0
var ok = 0
var missed = 0
var score = 0
var nivel_actual = 0
var musico_actual = 0
# ACA SE PUEDEN AGREGAR VARIABLES QUE CONTROLEN QUE NIVELES SE PASARON Y CON QUE PUNTAJE
# SI SE PASO EL NIVEL 1 CON AL MENOS UN MUSICO SE PUEDE ACCEDER AL NIVEL 2

func set_score(num):
	score = num

func set_perfect(num):
	perfect = num
	
func set_good(num):
	good = num

func set_ok(num):
	ok = num

func set_missed(num):
	missed = num
	
func set_nivel(num):
	nivel_actual = num

func set_musico(num):
	musico_actual = num
