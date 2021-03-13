extends Node2D

export(NodePath) var alvo
export(PackedScene) var tiro
var activated = false
export var inverted = false

func _ready():
	alvo = get_node(alvo)


func _process(_delta):
	if !activated:
		return
	
	if (alvo.position.x >= position.x) == inverted:
		rotation = position.angle_to_point(Vector2(alvo.position))

func toggle():
	set_activated(!activated)

func set_activated(a):
	activated = a


func _on_Timer_timeout():
	if !activated:
		return
	
	if position.distance_to(alvo.position) <= 1250:
		var new = tiro.instance()
		get_parent().add_child(new)
		new.global_position = $Sprite2.global_position
		new.set_alvo(alvo)
