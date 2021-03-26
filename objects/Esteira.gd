extends Node2D

export var size = 1080;
export var velocidade = 160;
export var extend_ratio = 1.0

var animation = 0
var activated = false

var body_array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	$Dir.position.x = size
	$Meio.set_region_rect(Rect2(0, 0, size, 32))
	if velocidade < 0:
		$Meio.position.x += size
		$Meio.scale.x *= -1
	
	$StaticBody2D.position.x = size/2
	$StaticBody2D/CollisionShape2D.scale.x = size/2
	
	$Area2D.position.x = size/2
	$Area2D/CollisionShape2D.scale.x = size*extend_ratio/2


func toggle():
	activated = !activated


func _physics_process(delta):
	if !activated:
		return
	
	if animation < -32:
		animation = 0
		
	animation -= abs(velocidade*delta)
	$Meio.set_region_rect(Rect2(animation, 0, size, 32))
	
	# Move bodies
	for body in body_array:
		body.position.x += velocidade*delta


func _on_Area2D_body_entered(body):
	body_array.append(body)


func _on_Area2D_body_exited(body):
	body_array.erase(body)
	
	if body.has_method("set_center") and body.acceleration == Vector2(0, 0):
		body.set_center(null)
