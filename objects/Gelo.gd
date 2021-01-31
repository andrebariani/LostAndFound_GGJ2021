extends Node2D


func _on_Area2D_body_entered(body):
	body.floor_friction = 0


func _on_Area2D_body_exited(body):
	body.floor_friction = body.FLOOR_FRICTION
