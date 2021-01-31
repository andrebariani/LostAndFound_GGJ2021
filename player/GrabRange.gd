extends Area2D

var p = null
signal can_grab

var item_in_range
var is_held = false

var item_base = preload("res://Items/ItemBase.tscn")

var item = {
	texture = Texture,
	id = 0,
	item_name = ""
}

onready var item_sprite = $ItemPlace/Sprite
onready var collision = $CollisionShape2D
onready var timer = $Timer


func init(_p):
	p = _p


func grab_nearest():
	if item_in_range:
		collision.disabled = true
		item.texture = item_in_range.texture
		item.id = item_in_range.id
		item.item_name = item_in_range.item_name
		item_sprite.texture = item_in_range.sprite.texture
		item_in_range.queue_free()
		item_in_range = null
		item_sprite.visible = true
		is_held = true


func throw():
	if item_sprite.visible == true and is_held == true:
		var i = item_base.instance()
		i.texture = item.texture
		i.id = item.id
		i.item_name = item.item_name
		i.global_position = $ItemPlace.global_position
		if p.input_dir_vector.x != 0:
			i.throw(p.ori)
		else:
			i.throw(0)
		p.get_parent().add_child(i)
		timer.start()
		item_sprite.visible = false
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
