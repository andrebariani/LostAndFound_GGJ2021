extends "res://objects/O2Area.gd"

var spaceEffect = AudioServer.get_bus_effect(1, 0)

func _on_Area2D_body_entered(body):
	if body.has_method("lose_oxygen"):
		if spaceEffect:
			spaceEffect.cutoff_hz = 1500
		body.gravity_on = false


func _on_Area2D_body_exited(body):
	if body.has_method("lose_oxygen"):
		if spaceEffect:
			spaceEffect.cutoff_hz = 20000
		body.gravity_on = true
