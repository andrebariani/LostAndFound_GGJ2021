extends Label

var clock = 0
export var tempo_inicial = 0
export var tempo_perigo = 100000000

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
	text = ""
	text += str(horas)
	
	# Minutos
	var minutos = clock%60
	if minutos < 10:
		text += ":0"
	else:
		text += ":"
	text += str(minutos)
	
	if clock > tempo_perigo:
		modulate = Color.red
