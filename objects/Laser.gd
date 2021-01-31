extends "res://objects/Damage.gd"

var present = true
var activated = false
export(Texture) var sprite


func _ready():
	$Sprite.texture = sprite
	_on_Timer_timeout()


func toggle():
	set_activated(!activated)


func set_activated(a):
	activated = a
	if !activated:
		$Timer.stop()
		if present:
			position.y += 100000
			present = false
		
	else:
		$Timer.start()


func _on_Area2D_body_entered(body):
	if !activated:
		return
	
	deal_damage(body)


func _on_Timer_timeout():
	if present:
		position.y += 100000
	else:
		position.y -= 100000
	
	present = !present
