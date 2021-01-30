extends Node2D

export var activated = true
var present = true

func set_activated(new):
	set_present(new)
	activated = new
	$Timer.paused = !activated
	$Grace.paused = !activated


func set_present(new):
	if !activated:
		return
	
	present = new
	print_debug(present)
	if !present:
		$TileMap.position.y = 10000
		$Timer.start(1)
	else:
		$TileMap.position.y = 0


func _on_Area2D_body_entered(_body):
	$Grace.start(0.25)

func _on_Timer_timeout():
	set_present(true)

func _on_Grace_timeout():
	set_present(false)
