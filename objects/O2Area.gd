extends Node2D

var player = null
var wait_and_see = false

func _on_Area2D_body_entered(body):
	if body.has_method("lose_oxygen"):
		player = body
		player.add_breathing(1)
		$Timer.start(1)


func _on_Area2D_body_exited(body):
	if body.has_method("fill_oxygen"):
		body.add_breathing(-1)
		wait_and_see = true
		$Timer.start(0.1)


func _on_Timer_timeout():
	if player != null:
		if wait_and_see:
			if player.get_breathing() <= 0:
				player.fill_oxygen()
			$Timer.stop()
			wait_and_see = false
			player = null
		else:
			player.lose_oxygen()
