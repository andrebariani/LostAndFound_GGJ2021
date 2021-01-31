extends "res://objects/O2Area.gd"

var spaceEffect = AudioServer.get_bus_effect(1, 0)

func _on_Area2D_body_entered(body):
	if body.has_method("lose_oxygen"):
		player = body
		player.set_in_space(true)
		$Timer.start(0.25)
		player.timer_setup()
		if spaceEffect:
			spaceEffect.cutoff_hz = 2000

	elif body.has_method("throw"):
		body.weight = 0


func _on_Area2D_body_exited(body):
	if body == player:
		if spaceEffect:
			spaceEffect.cutoff_hz = 20000
		$Timer.stop()

	elif body.has_method("throw"):
		body.weight = 9.8
