extends "res://objects/Damage.gd"

var present = false
var activated = false
export(Texture) var sprite


func _ready():
	$Sprite.texture = sprite
	position.y += 100000


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
		$Timer.start(2)


func _on_Area2D_body_entered(body):
	if !present:
		return
	
	deal_damage(body)


func _on_Timer_timeout():
	if !activated:
		return
	
	if present:
		position.y += 100000
		$Timer.start(2)
		$sfx.play()
	else:
		position.y -= 100000
		$Timer.start(0.5)
		$sfx.stop()
	
	present = !present
