extends Node

var spawn_points = []
export var objects = []
var current_obj = 0
export(NodePath) var object_node

func new_quest():
	var new = objects[current_obj].instance()
	object_node.add_child(new)
	new.position = spawn_points[current_obj]
	
	current_obj += 1
