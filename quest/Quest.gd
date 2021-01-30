extends Node

var spawn_points = []
export(PackedScene) var object_scene
export var clients = []
export(NodePath) var player
var dialog

var total_time = 0
var times = []
var current_obj = 0
var received = 0
var content = 0
var active_quests = []

signal change_sprite
signal new_dialog
signal second_passed
signal endgame


func _ready():
	dialog = [
		[("Aí, filho, o moço trouxe a Sukita. Agora, bebe e " +
		"fica quietinho, ok?!"), "Eba! Valeu, tio!"],
		["Obrigado!"],
		["Obrigado!"],
		["Obrigado!"],
		["Obrigado!"],
		["Obrigado!"],
		["Obrigado!"],
		["Obrigado!"],
		["Obrigado!"],
	]


func new_quest():
	if active_quests.size() >= 3 or current_obj >= 8:
		return
	
	times.append(0)
	active_quests.append(current_obj)
	emit_signal("change_sprite", clients[current_obj])
	current_obj += 1


func receive_order(id):
	if id in active_quests:
		emit_signal("change_sprite", clients[id])
		emit_signal("new_dialog", dialog[id])
		$Timer.stop()
		active_quests.erase(id)
	
	if times[id] <= 120:
		content += 1
	received += 1
	emit_signal("change_sprite", clients[current_obj])


func finalize_order():
	$Timer.start()
	if received >= 9:
		endgame()


func endgame():
	var pontuacao = content*60
	pontuacao -= total_time
	
	#vitoria, vidas, tempo, satisfacao, count, pontuacao
	emit_signal("endgame", true, 0, total_time, content, 9, pontuacao)


func _on_Timer_timeout():
	for i in range(current_obj):
		times[i] += 1
	total_time += 1
	emit_signal("second_passed")
