extends "res://objects/Damage.gd"

export var speed = 600

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.y += speed*delta
	speed += 10*delta # aceleracao


func _on_Area2D_body_entered(body):
	deal_damage(body)
	queue_free()
