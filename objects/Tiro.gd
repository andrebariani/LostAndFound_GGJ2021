extends "res://objects/Damage.gd"

var alvo
export var speed = 600

func set_alvo(a):
	alvo = position.direction_to(Vector2(a.position))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += alvo*speed*delta


func _on_Area2D_body_entered(body):
	deal_damage(body)
	queue_free()
