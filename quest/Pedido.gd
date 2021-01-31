extends Control

var id = 0
var index = 0

func setup(sprite, id_, area):
	$Icon.texture = sprite
	id = id_
	$Area.text = area

func clock():
	$Relogio.relogio()

func get_id():
	return id

func set_index(a):
	index = a

func get_index():
	return index
