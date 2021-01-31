extends Area2D

var p = null
signal can_grab

var item_in_range
var is_held = false

export var item_base = preload("res://Items/ItemBase.tscn")

var item = {
	texture = Texture,
	id = 0,
	item_name = "",
	dispenser = null
}
var item_instance = null

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
		item.dispenser = item_in_range.dispenser
		item_sprite.texture = item_in_range.sprite.texture
		item_in_range.queue_free()
		item_in_range = null
		set_visible(true)
		is_held = true
		return true
	return false


func throw():
	if is_held == true:
		var i = item_base.instance()
		i.setup(item.texture, item.id, item.item_name, item.dispenser)
		i.global_position = $ItemPlace.global_position
		if p.input_dir_vector.x != 0:
			i.throw(p.ori)
		else:
			i.throw(0)
		p.get_parent().add_child(i)
		timer.start()
		set_visible(false)
		is_held = false
		
		return i


func destroy():
	if is_held:
		throw().destroy()


func set_visible(vis):
	item_sprite.visible = vis


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
