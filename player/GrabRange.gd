extends Area2D

var p = null
signal can_grab

var item_in_range
var is_held = false

var item = preload("res://Items/ItemBase.tscn")

onready var place = $ItemPlace/Sprite
onready var collision = $CollisionShape2D
onready var timer = $Timer


func init(_p):
	p = _p


func _physics_process(delta):
	pass


func grab_nearest():
	if item_in_range:
		collision.disabled = true
		item_in_range.queue_free()
		item_in_range = null
		place.visible = true
		is_held = true


func throw():
	if place.visible == true and is_held == true:
		var i = item.instance()
		i.global_position = $ItemPlace.global_position
		if p.input_dir_vector.x != 0:
			i.throwed(p.ori)
		else:
			i.throwed(0)
		p.get_parent().add_child(i)
		timer.start()
		place.visible = false
		is_held = false


func _on_GrabRange_body_entered(body):
	if item_in_range == null and body.name.find("Item") != -1:
		body.set_in_range(true)
		item_in_range = body


func _on_GrabRange_body_exited(body):
	if item_in_range and not is_held:
		if body.get_instance_id() == item_in_range.get_instance_id():
			item_in_range = null
			body.set_in_range(false)


func _on_Timer_timeout():
	collision.disabled = false
