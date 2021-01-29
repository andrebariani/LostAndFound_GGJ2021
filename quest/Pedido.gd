extends Control

var id = 0

func setup(sprite, id):
	$Icon.texture = sprite
	self.id = id


func clock():
	$Relogio.clock()


func get_id():
	return id
