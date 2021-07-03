extends Node2D


var nivel_actual = 0  # 3 niveles (museos), con 1 canción diferente en cada uno
var musico_actual = 0 # 3 tipos de dificultad por nivel (musicos)

# parametros/ajustes/configuracion..?? de cada nivel dependiendo el musico a encontrarse
#  - Cargar Libertango (por ahi podria ser la cancion del nivel 3)


#  - Cargar Adios Nonino
var nivel1_musico1 = {
	"cancion": "res://assets/music/Adios_Nonino.mp3",
	 "bpm": 81, 
	"lanes": 2,
	"spawn_multiplier": 1,
	 "bandoneon_prob": [0,100,100,0],
	"trap_prob": 0
	}
var nivel1_musico2 = {
	"cancion": "res://assets/music/Adios_Nonino.mp3",
	"bpm": 81, 
	"lanes": 3,
	"spawn_multiplier" : 1,
	 "bandoneon_prob": [0,50,80,10],
	"trap_prob": 5
	}
var nivel1_musico3 = {
	"cancion": "res://assets/music/Adios_Nonino.mp3",
	"bpm": 81, 
	"lanes": 4,
	"spawn_multiplier" : 1,
	 "bandoneon_prob": [80,50,10,10],
	"trap_prob": 10
	}

#  - Cargar Verano Porteño
var nivel2_musico1 = {
	"cancion": "res://assets/music/Verano_Portenio.mp3",
	"bpm": 134, 
	"lanes": 2,
	"spawn_multiplier" : 1,
	 "bandoneon_prob": [80,50,80,10],
	"trap_prob": 5
	}
var nivel2_musico2 = {
	"cancion": "res://assets/music/Verano_Portenio.mp3",
	"bpm": 134, 
	"lanes": 3,
	"spawn_multiplier" : 1,
	 "bandoneon_prob": [80,50,10,80],
	"trap_prob": 10
	}
var nivel2_musico3 = {
	"cancion": "res://assets/music/Verano_Portenio.mp3",
	"bpm": 134, 
	"lanes": 4,
	"spawn_multiplier" : 1,
	 "bandoneon_prob": [80,50,100,50],
	"trap_prob": 10
	}

var nivel3_musico1 = {
	"cancion": "res://assets/music/Libertango.mp3",
	"bpm": 159,
	"lanes": 2, # solo se spawnearan notas en los 2 primeros carriles
	"spawn_multiplier" : 1,
	 "bandoneon_prob": [80,80,50,50],
	"trap_prob": 5
	
}
var nivel3_musico2 = {
	"cancion": "res://assets/music/Libertango.mp3",
	"bpm": 159, 
	"lanes": 3,
	"spawn_multiplier" : 1,
	 "bandoneon_prob": [100,100,80,80],
	"trap_prob": 10
}
var nivel3_musico3 = {
	"cancion": "res://assets/music/Libertango.mp3",
	"bpm": 159, 
	"lanes": 4,
	"spawn_multiplier" : 1,
	 "bandoneon_prob": [100,100,100,100],
	"trap_prob": 10
	}
	
func _ready():
	pass

func get_nivel():
	if (nivel_actual == 1):
		if(musico_actual == 1):
			return nivel1_musico1
		elif(musico_actual == 2):
			return nivel1_musico2
		elif(musico_actual == 3):
			return nivel1_musico3
	elif (nivel_actual == 2):
		if(musico_actual == 1):
			return nivel2_musico1
		elif(musico_actual == 2):
			return nivel2_musico2
		elif(musico_actual == 3):
			return nivel2_musico3
	elif (nivel_actual == 3):
		if(musico_actual == 1):
			return nivel3_musico1
		elif(musico_actual == 2):
			return nivel3_musico2
		elif(musico_actual == 3):
			return nivel3_musico3


func set_nivel(num):
	nivel_actual = num

func set_musico(num):
	musico_actual = num
