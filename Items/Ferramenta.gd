extends "res://Items/ItemBase.gd"

var destroyed = false

func is_tool():
	return true

func destroy():
	if !destroyed:
		destroyed = true
		dispenser.spawn()
		queue_free()
