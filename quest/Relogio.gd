extends Label

var clock = 0
export var tempo_inicial = 0

func reset():
	clock = 0
	text = "10:00"

func get_time():
	return clock

# Relogio em si -------------
func _ready():
	clock = tempo_inicial


func relogio():
	clock += 1
	# Horas
	var horas = clock/60
	if horas < 10:
		text = "0"
	else:
		text = ""
	text += str(horas)
	
	# Minutos
	var minutos = clock%60
	if minutos < 10:
		text += ":0"
	else:
		text += ":"
	text += str(minutos)


func _on_Timer_timeout():
	relogio()
