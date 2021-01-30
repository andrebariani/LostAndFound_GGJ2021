extends Node2D

signal received_item

func set_sprite(sprite):
	$Alien.texture = sprite


func _on_Area2D_body_entered(body):
	if body.is_held:
		emit_signal("received_item", body.item.get_id())
