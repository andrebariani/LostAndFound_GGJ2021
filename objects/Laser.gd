extends "res://objects/Damage.gd"

var present = false
var activated = false
export(Texture) var sprite


func _ready():
	$Sprite.texture = sprite
	$Sprite.modulate.a = 0
	$Area2D.position.y = 100000


func _process(delta):
	if !present and $Timer.time_left > 0 and $Timer.time_left < 1:
		$Sprite.modulate.a = ((1.0 - $Timer.time_left))/2.0


func toggle():
	set_activated(!activated)


func set_activated(a):
	activated = a
	if !activated:
		$Timer.stop()
		$Sprite.modulate.a = 0
		if present:
			$Area2D.position.y = 100000
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
		$Area2D.position.y = 100000
		$Sprite.modulate.a = 0
		$Timer.start(2)
		$sfx.play()
	else:
		$Area2D.position.y = 0
		$Sprite.modulate.a = 1
		$Timer.start(0.5)
		$sfx.stop()
	
	present = !present
