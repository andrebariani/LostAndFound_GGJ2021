extends "res://objects/O2Area.gd"


func _on_Area2D_body_entered(body):
	if body.has_method("lose_oxygen"):
		body.gravity_on = false


func _on_Area2D_body_exited(body):
	if body.has_method("lose_oxygen"):
		body.gravity_on = true
