extends Control

export(PackedScene) var cena_pedido
var pedidos = []
var pedido_positions = []
var pedido_count = 0
const X_OFFSET = 238
const Y_OFFSET = 78

func add_pedido(sprite, id, area):
	var new = cena_pedido.instance()
	add_child(new)
	move_child(new, get_child_count()-1)
	new.setup(sprite, id, area)
	for i in range(3):
		if !(i in pedido_positions):
			pedido_positions.append(i)
			new.rect_position = Vector2(238, Y_OFFSET*i)
			new.set_index(i)
			break
	
	pedidos.append(new)


func delete_pedido(id):
	pedido_count += 1
	$Count.text = str(pedido_count) + "/9"
	for pedido in pedidos:
		if pedido.get_id() == id:
			pedido_positions.erase(pedido.get_index())
			pedidos.erase(pedido)
			pedido.queue_free()
			break


func clock():
	for pedido in pedidos:
		pedido.clock()
