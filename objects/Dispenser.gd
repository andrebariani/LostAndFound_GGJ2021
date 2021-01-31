extends Position2D


onready var item_base = preload("res://Items/ItemBase.tscn")


onready var item = {
	texture = Texture,
	id = 0,
	item_name = ""
}


func _physics_process(delta):
	if get_tree().get_nodes_in_group(item.item_name).size():
		var i = get_tree().get_nodes_in_group(item.item_name)[0]
		if i:
			if i.item_name == item.item_name:
				if i.destroyed:
					i.queue_free()
					spawn()

func _ready():
	var i = get_child(2)
	
	item.texture = i.texture
	item.id = i.id
	item.item_name = i.item_name


func spawn():
	var i = item_base.instance()
	i.texture = item.texture
	i.id = item.id
	i.item_name = item.item_name
	i.global_position = self.global_position
	print_debug(i.global_position)
	self.get_parent().add_child(i)
	
	
func force_spawn():
	if get_tree().get_nodes_in_group(item.item_name).size() != 0:
		var i = get_tree().get_nodes_in_group(item.item_name)[0]
		if i:
			if i.item_name == item.item_name:
				i.queue_free()
				spawn()
