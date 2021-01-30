extends RigidBody2D


var pos = Vector2(0,0)

onready var collision = $CollisionShape2D
onready var color = $ColorRect


func grabbed():
	print_debug("Item grabbed!")
	

func throwed(ori):
	print_debug("Item throwed!")
	#if ori != 0:
		#self.applied_force.x = 200 * ori


func set_in_range(v):
	pass
