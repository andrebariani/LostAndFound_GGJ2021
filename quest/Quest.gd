extends Node

var spawn_points = []
export var objects = []
var total_time = 0
var times = []
var current_obj = 0
var received = 0
var content = 0
export(NodePath) var object_node

signal second_passed
signal endgame

func new_quest():
	var new = objects[current_obj].instance()
	object_node.add_child(new)
	new.position = spawn_points[current_obj]
	new.setup(current_obj)
	
	times.append(0)
	current_obj += 1


func receive_order(id):
	if times[id] <= 120:
		content += 1
	received += 1
	
	if received >= objects.count():
		endgame()


func endgame():
	var pontuacao = content*60
	pontuacao -= total_time
	
	#vitoria, vidas, tempo, satisfacao, count, pontuacao
	emit_signal("endgame", true, 0, total_time, content, objects.count(), pontuacao)


func _on_Timer_timeout():
	for i in range(current_obj):
		times[i] += 1
	total_time += 1
	emit_signal("second_passed")
