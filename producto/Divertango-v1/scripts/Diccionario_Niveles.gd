extends Node2D


var nivel_actual = 0
var musico_actual = 0

# variables
var bpm 
var lanes

var nivel1_musico1 = {"bpm":160,"lanes":3}

func _ready():
	pass 

func getDiccionario():
	if (nivel_actual == 1):
		if(musico_actual == 1):
			return nivel1_musico1
		elif(musico_actual == 2):
			return nivel1_musico1
		elif(musico_actual == 3):
			return nivel1_musico1
	elif (nivel_actual == 2):
		if(musico_actual == 1):
			return nivel1_musico1
		elif(musico_actual == 2):
			return nivel1_musico1
		elif(musico_actual == 3):
			return nivel1_musico1
	elif (nivel_actual == 3):
		if(musico_actual == 1):
			return nivel1_musico1
		elif(musico_actual == 2):
			return nivel1_musico1
		elif(musico_actual == 3):
			return nivel1_musico1


func set_nivel(num):
	nivel_actual = num

func set_musico(num):
	musico_actual = num
