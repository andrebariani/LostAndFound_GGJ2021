extends Node2D

export var activated = true

func toggle():
	activated = !activated

func _on_Area2D_body_entered(body):
	if activated:
		if body.has_method("apply_velocity"):
			body.hyperjump = 1
			body.position.y -= 10
