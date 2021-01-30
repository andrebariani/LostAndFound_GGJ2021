extends Node2D

export(NodePath) var alvo
export(PackedScene) var tiro
var activated = false

func _ready():
	alvo = get_node(alvo)


func _process(delta):
	if !activated:
		return
	
	rotation = position.angle_to_point(Vector2(alvo.position))


func set_activated(a):
	activated = a


func _on_Timer_timeout():
	if !activated:
		return
	
	print_debug(position.distance_to(alvo.position))
	
	if position.distance_to(alvo.position) <= 1250:
		var new = tiro.instance()
		get_parent().add_child(new)
		new.position = position
		new.set_alvo(alvo)
