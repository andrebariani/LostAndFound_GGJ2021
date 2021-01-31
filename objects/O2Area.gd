extends Node2D

var player = null
var wait_and_see = false

func _on_Area2D_body_entered(body):
	if body.has_method("lose_oxygen"):
		player = body
		$Timer.start(0.25)
		player.timer_setup()


func _on_Area2D_body_exited(body):
	if body == player:
		$Timer.stop()


func _on_Timer_timeout():
	if player != null:
		player.lose_oxygen()
