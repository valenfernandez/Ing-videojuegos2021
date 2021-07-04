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
var hitted_note = false

func set_puntos(num):
	puntos=num

func hitted():
	hitted_note = true
	
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
	if lane == 0:
		$AnimatedSprite.frame = 0 #tipo de nota trampa
		position = FIRST_LANE_SPAWN 
	elif lane == 1:
		$AnimatedSprite.frame = 1
		position = SECOND_LANE_SPAWN
	elif lane == 2:
		$AnimatedSprite.frame = 2
		position = THIRD_LANE_SPAWN
	elif lane == 3:
		$AnimatedSprite.frame = 3
		position = FORTH_LANE_SPAWN
	else:
		printerr("Invalid lane set for note: " + str(lane))
		return
	speed = DIST_TO_TARGET / 10.0
	
func destroy():
	$CPUParticles2D.emitting = true
	$AnimatedSprite.visible = false
	$Timer.start()
	$Node2D/Label.text = "NOTA TRAMPA!"
	$Node2D/Label.modulate = Color("900c3f")
	


func _on_Timer_timeout():
	queue_free()
