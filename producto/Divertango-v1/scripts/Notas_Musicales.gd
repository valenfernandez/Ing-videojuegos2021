extends Area2D


# Declare member variables here. Examples:
const TARGET_X = 230
const SPAWN_X = 920
const DIST_TO_TARGET = SPAWN_X - TARGET_X

const FIRST_LANE_SPAWN = Vector2(SPAWN_X, 80) #ver si estos valores de x e y estan en los carrilles
const SECOND_LANE_SPAWN = Vector2(SPAWN_X, 144)
const THIRD_LANE_SPAWN = Vector2(SPAWN_X, 200)
const FORTH_LANE_SPAWN = Vector2(SPAWN_X, 270)

var speed = 0
var hit = false
var puntos=0

func set_puntos(num):
	puntos=num
	
func get_puntos():
	return puntos
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	if !hit:
		position.x -= speed * delta
		if position.x < 200:
			queue_free()
	else:
		$Node2D.position.x -= speed * delta


func initialize(lane):
	if lane == 0:
		$AnimatedSprite.frame = 0 #blanca
		position = FIRST_LANE_SPAWN 
	elif lane == 1:
		$AnimatedSprite.frame = 1 # negra
		position = SECOND_LANE_SPAWN
	elif lane == 2:
		$AnimatedSprite.frame = 2 #corchea
		position = THIRD_LANE_SPAWN
	elif lane == 3:
		$AnimatedSprite.frame = 3 #semicorchea
		position = FORTH_LANE_SPAWN
	else:
		printerr("Invalid lane set for note: " + str(lane))
		return
	
	speed = DIST_TO_TARGET / 10.0


func destroy(score):
	$CPUParticles2D.emitting = true
	$AnimatedSprite.visible = false
	$Timer.start()
	hit = true
	if score == 3: 
		$Node2D/Label.text = "PERFECTO"
		$Node2D/Label.modulate = Color("f6d6bd")
	elif score == 2:
		$Node2D/Label.text = "BIEN"
		$Node2D/Label.modulate = Color("c3a38a")
	elif score == 1:
		$Node2D/Label.text = "OKAY"
		$Node2D/Label.modulate = Color("997577")
	else:
		$Node2D/Label.text = "NOTA PERDIDA"
		$Node2D/Label.modulate = Color("997577") #CAMBIAR
		print(score)
	


func _on_Timer_timeout():
	queue_free()
