extends Area2D


const TARGET_X = 230
const SPAWN_X = 920
const DIST_TO_TARGET = SPAWN_X - TARGET_X

const FIRST_LANE_SPAWN = Vector2(SPAWN_X, 80) 
const SECOND_LANE_SPAWN = Vector2(SPAWN_X, 144)
const THIRD_LANE_SPAWN = Vector2(SPAWN_X, 210)
const FORTH_LANE_SPAWN = Vector2(SPAWN_X, 270)

var speed = 0
var hit = false
var puntos=0

func set_puntos(num):
	puntos=num
	
func get_puntos():
	return puntos

func get_class():
	return "Notas_Trampa"

func _ready():
	pass 

func _physics_process(delta):
	if !hit:
		position.x -= speed * delta
		if position.x < 200:
			queue_free()
	else:
		$Node2D.position.x -= speed * delta
		
func initialize(enabeled_lanes):
	var lane = randi() % enabeled_lanes
	var note = randi() % 2
	$AnimatedSprite.frame = note #tipo de nota trampa
	if lane == 0:
		position = FIRST_LANE_SPAWN 
	elif lane == 1:
		position = SECOND_LANE_SPAWN
	elif lane == 2:
		position = THIRD_LANE_SPAWN
	elif lane == 3:
		position = FORTH_LANE_SPAWN
	else:
		printerr("Invalid lane set for note: " + str(lane))
		return
	speed = DIST_TO_TARGET / 10.0
	
func destroy(score):
	$CPUParticles2D.emitting = true
	$AnimatedSprite.visible = false
	$Timer.start() 
	if score <= 0: 
		$Node2D/Label.text = "NOTA TRAMPA"
		$Node2D/Label.modulate = Color("f6d6bd")
	


func _on_Timer_timeout():
	queue_free()
