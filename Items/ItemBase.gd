extends RigidBody2D

export var texture: Texture
export var id: int
export var item_name: String

onready var collision = $CollisionShape2D
onready var sprite = $Sprite
onready var dispenser = get_parent()

var pos = Vector2(0,0)
var destroyed = false


func _ready():
	self.add_to_group(item_name)
	sprite.texture = texture


func throw(_v):
	pass


func destroy():
	dispenser.spawn()
	destroyed = true


func set_in_range(_v):
	pass


func get_id():
	return id
