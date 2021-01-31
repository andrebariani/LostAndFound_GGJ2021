extends "res://player/GrabRange.gd"

func destroy():
	pass


func set_visible(_vis):
	pass


func _on_GrabRange_body_entered(body):
	if item_in_range == null and body.has_method("is_tool"):
		body.set_in_range(true)
		item_in_range = body
