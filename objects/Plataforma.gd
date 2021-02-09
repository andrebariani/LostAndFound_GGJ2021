extends Node2D

export var velocidade = 5
export var distancia = 1000
export var direcaox = 0
export var direcaoy = 0
var origin_position = 0
var diffpos = 0
export var activated = true
var distancing = true

var body_array = []
var item_array = []

func _ready():
	origin_position = self.position


func _process(_delta):
	for item in item_array:
		item.global_position = $Area2D.global_position
	
	if activated == false:
		return
	
	# Calculate movement
	var x = int(self.position.x - origin_position.x) 
	var y = int(self.position.y - origin_position.y)
	diffpos = sqrt(pow(x,2) + pow(y,2))
	if (diffpos >= (distancia) and distancing) or (diffpos <= 3 and !distancing):
		invert_direction()
		
	# Execute movement
	self.position.x = self.position.x + (velocidade*direcaox)
	self.position.y = self.position.y + (velocidade*direcaoy) 
	
	# Move bodies
	for body in body_array:
		body.position.x = body.position.x + (velocidade*direcaox)
		body.position.y = body.position.y + (velocidade*direcaoy) 


func toggle():
	set_activated(!activated)

func set_activated(new):
	activated = new

func invert_direction():
	distancing = !distancing
	direcaox = direcaox * -1
	direcaoy = direcaoy * -1


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body_array.append(body)
	else:
		item_array.append(body)

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		body_array.erase(body)
	else:
		item_array.append(body)
