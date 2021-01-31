extends "res://objects/Damage.gd"

func _on_Area2D_body_entered(body):
	deal_damage(body)


