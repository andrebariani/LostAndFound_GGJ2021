extends Node2D


func deal_damage(body):
	if body.has_method("take_damage"):
		body.take_damage()
