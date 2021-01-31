extends Node2D

var player = null
var wait_and_see = false

func _on_Area2D_body_entered(body):
	if body.has_method("lose_oxygen"):
		player = body
		player.set_breathing(false)
		$Timer.start()


func _on_Area2D_body_exited(body):
	if body.has_method("fill_oxygen"):
		player.set_breathing(true)
		wait_and_see = true
		$Timer.start(0.2)


func _on_Timer_timeout():
	if player != null:
		if wait_and_see and player.get_breathing():
			player.fill_oxygen()
			$Timer.stop()
			player = null
		else:
			player.lose_oxygen()
