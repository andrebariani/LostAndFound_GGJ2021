extends Control

var display_types = ["dano","tempo","satisfacao","score"]
var display_type = 3
var jogadores = []

class MyCustomSorter:
	static func sort_dano(a, b):
		if a["dano"] < b["dano"]:
			return true
		return false
	
	static func sort_tempo(a, b):
		if a["tempo"] < b["tempo"]:
			return true
		return false
	
	static func sort_satisfacao(a, b):
		if a["satisfacao"] > b["satisfacao"]:
			return true
		return false
	
	static func sort_score(a, b):
		if a["score"] > b["score"]:
			return true
		return false

func _ready():
	$HTTPRequest.request('https://iss-leaderboards.herokuapp.com/?view=a')


func _make_post_request(url, data_to_send, use_ssl):
	var headers = ["Content-Type: application/json"]
	$HTTPRequest.request(url, [], use_ssl, HTTPClient.METHOD_POST, to_json(data_to_send))


func _input(event):
	if event.is_action_pressed("dash"):
		if display_type < len(display_types)-1:
			display_type += 1
		else:
			display_type = 0
		
		$Categoria/Label.text = display_types[display_type]
		display()


func _on_HTTPRequest_request_completed(_result, response_code, _headers, body):
	print_debug(body)
	var json = JSON.parse(body.get_string_from_utf8())
	jogadores = json.result
	print_debug(json.result)
	print_debug("Code: " + str(response_code))
	$Carregando.text = ""
	
	display()


func display():
	jogadores.sort_custom(MyCustomSorter, "sort_" + display_types[display_type])
	
	for i in range(min(7, len(jogadores))):
		$Jogadores.get_child(i).get_node("Nome").text = jogadores[i]["nome"]
		$Jogadores.get_child(i).get_node("Valor").text = jogadores[i][display_types[display_type]]
