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


func throw():
	pass


func destroy():
	destroyed = true
	
	
func set_in_range(v):
	pass
