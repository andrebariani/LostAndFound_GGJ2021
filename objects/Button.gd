extends Area2D

onready var p = null
onready var d = get_parent()

func _on_Button_body_entered(body):
	if body.name == "Player":
		p = body


func _on_Button_body_exited(body):
	if body.name == "Player":
		p = null


func _physics_process(delta):
	if p:
		if p.inputs.grab:
			d.force_spawn()
