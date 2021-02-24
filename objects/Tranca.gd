extends Node2D

var activated = false

func toggle():
	if activated:
		position.y += 100000
		activated = false
	else:
		position.y -= 100000
		activated = true
