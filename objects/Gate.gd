extends Node2D

var upper_target
var lower_target
var finished = false
var opened = false

export var start_open = false
export var last_gate = false

const UPPER_OPEN = Vector2(0, -120)
const UPPER_CLOSED = Vector2(0, 35)
const LOWER_OPEN = Vector2(0, 120)
const LOWER_CLOSED = Vector2(0, -35)

func _ready():
	upper_target = $Upper.position
	lower_target = $Lower.position
	if start_open:
		open()

func _physics_process(delta):
	if !finished:
		if abs((upper_target - $Upper.position).y) > 0.01 || abs((upper_target - $Upper.position).x) > 0.01:
			$Upper.position += 2*delta*(upper_target - $Upper.position)
			$Lower.position += 2*delta*(lower_target - $Lower.position)
		else:
			finished = true


func toggle():
	if opened:
		close()
	else:
		open()


func open():
	upper_target = UPPER_OPEN
	lower_target = LOWER_OPEN
	finished = false
	opened = true


func close():
	upper_target = UPPER_CLOSED
	lower_target = LOWER_CLOSED
	finished = false
	opened = false
