extends Control

export(PackedScene) var cena_pedido
var pedido_count = 0
const X_OFFSET = 238
const Y_OFFSET = 78

func add_pedido(_sprite):
	var new = cena_pedido.instance()
	add_child(new)
	move_child(new, get_child_count()-1)
	new.setup(_sprite)
	
	new.rect_position = Vector2(238, Y_OFFSET*pedido_count)
	pedido_count += 1
	$Count.text = str(pedido_count) + "/8"
