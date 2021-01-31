extends RigidBody2D

export var texture: Texture
export var id: int
export var item_name: String

onready var collision = $CollisionShape2D
onready var sprite = $Sprite
var dispenser = null

var pos = Vector2(0,0)
var destroyed = false


func _ready():
	if dispenser == null:
		dispenser = get_parent()
	
	self.add_to_group(item_name)
	sprite.texture = texture


func setup(_texture, _id, _item_name, _dispenser):
	texture = _texture
	id = _id
	item_name = _item_name
	dispenser = _dispenser


func throw(_v):
	pass


func destroy():
	dispenser.spawn()
	destroyed = true
	queue_free()


func set_in_range(_v):
	pass


func get_id():
	return id
