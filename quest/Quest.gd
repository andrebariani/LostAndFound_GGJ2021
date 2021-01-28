extends Node

var spawn_points = []
export var objects = []


func new_quest():
	var new = objects[randi() % objects.size()].instance()
	new.position = spawn_points[randi() % spawn_points.size()]
	
	return new
