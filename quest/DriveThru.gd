extends Node2D

signal received_item

func set_sprite(sprite):
	$Alien.texture = sprite


func _on_Area2D_body_entered(body):
	if body.has_method("is_held") and body.is_held():
		emit_signal("received_item", body.get_item_id())
		$sfx.play()


func _on_Quest_change_sprite(sprite):
	set_sprite(sprite)
