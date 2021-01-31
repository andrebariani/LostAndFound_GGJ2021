extends Control

var id = 0

func setup(sprite, id_):
	$Icon.texture = sprite
	id = id_

func clock():
	$Relogio.clock()

func get_id():
	return id
