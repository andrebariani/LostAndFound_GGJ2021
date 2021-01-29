extends Control

export(PackedScene) var cena_pedido
var pedidos = []
var pedido_count = 0
const X_OFFSET = 238
const Y_OFFSET = 78

func add_pedido(sprite, id):
	var new = cena_pedido.instance()
	add_child(new)
	move_child(new, get_child_count()-1)
	new.setup(sprite, id)
	new.rect_position = Vector2(238, Y_OFFSET*pedido_count)
	
	pedidos.append(new)
	pedido_count += 1
	$Count.text = str(pedido_count) + "/8"


func delete_pedido(id):
	for pedido in pedidos:
		if pedido.get_id() == id:
			pedidos.erase(pedido)
			break


func clock():
	for pedido in pedidos:
		pedido.clock()
