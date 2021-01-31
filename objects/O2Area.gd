extends Node2D

var player = null


func _on_Area2D_body_entered(body):
	if body.has_method("lose_oxygen"):
		player = body
		$Timer.start()


func _on_Area2D_body_exited(body):
	if body.has_method("fill_oxygen"):
		body.fill_oxygen()
		player = null
		$Timer.stop()


func _on_Timer_timeout():
	if player != null:
		player.lose_oxygen()
