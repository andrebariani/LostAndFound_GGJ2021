extends Area2D

export var item_base = preload("res://Items/ItemBase.tscn")

export var item = {
	texture = Texture,
	id = 0,
	item_name = ""
}

func _ready():
	pass


func spawn():
	get_tree().call_group(item.item_name, "destroy")
	
	var i = item_base.instance()
	i.add_to_group(item.item_name)
	i.texture = item.texture
	i.id = item.id
	i.item_name = item.item_name
	i.global_position = self.global_position
	i.dispenser = self
	self.get_parent().add_child(i)
	return i
	
	
func force_spawn():
	if get_tree().get_nodes_in_group(item.item_name).size() != 0:
		var i = get_tree().get_nodes_in_group(item.item_name)[0]
		if i:
			if i.item_name == item.item_name:
				i.queue_free()
				spawn()

