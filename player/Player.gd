extends KinematicBody2D

export (int) var MAX_SPEED = 300
export (int) var MAX_JUMP = 300
export (int) var MIN_JUMP = 300
export (int) var FLOOR_ACC = 175
export (int) var FLOOR_FRICTION = 125
export (int) var AIR_ACC = 125
export (int) var GRAVITY = 30
export (int) var AIR_FINAL_SPEED = 1100
export (int) var COYOTE_JUMP_FRAMES = 7
export (bool) var CAN_DASH = true
export (int) var DASH_SPEED = 700
export (int) var DASH_FRAMES = 15
enum GRAVITY_DIR { DOWN, RIGHT, UP, LEFT }
export(GRAVITY_DIR) var START_GRAVITY_DIR
export (int) var MAX_AIRHOP = 0
export (bool) var CAN_WALLJUMP = true
export (int) var WALLSLIDE_SPEED = 100
export (int) var WALLJUMP_FRAMES = 10
export (int) var AIR_MOMENTUM_FRAMES = 10


onready var sm = $States
onready var inputHelper = $Inputs
onready var playerBody = $PlayerBody
onready var grabRange = $PlayerBody/GrabRange
onready var debug = $Debug


onready var max_speed = MAX_SPEED
onready var gravity = GRAVITY
onready var air_final_speed = AIR_FINAL_SPEED
onready var max_jump = MAX_JUMP
onready var min_jump = MIN_JUMP
onready var floor_acc = FLOOR_ACC
onready var floor_friction = FLOOR_FRICTION
onready var air_acc = AIR_ACC
onready var dash_speed = DASH_SPEED
onready var wallslide_speed = WALLSLIDE_SPEED


var velocity = Vector2(0,0)
var velocity_jump = 0
var velocity_move = 0

var ori = 1
var gravity_dir
var gravity_on = true
var floor_jump = false
var floor_normal = Vector2(0,0)


var input_dir_vector = Vector2(0,0)
var last_input_dir_vector = Vector2(0,0)
var last_velocity_move_sign # Used mainly in walljump


var inputs = {
	jump_p = 0,
	jump_jp = 0,
	jump_jr = 0,
	sprint = 0,
	dash = 0,
	grab = 0
}


var cooldowns = {
	"coyote": {
		max_value = COYOTE_JUMP_FRAMES,
		value = COYOTE_JUMP_FRAMES
	},
	"dash": {
		max_value = DASH_FRAMES,
		value = DASH_FRAMES
	},
	"walljump": {
		max_value = WALLJUMP_FRAMES,
		value = WALLJUMP_FRAMES
	},
	"air_momentum": {
		max_value = AIR_MOMENTUM_FRAMES,
		value = AIR_MOMENTUM_FRAMES
	},
}


var has_control = true
var debug_on = true
var is_held = false


var item
var checkpoint_pos


func _ready():
	sm.init(self, "Idle")
	inputHelper.init(self)
	grabRange.init(self)
	gravity_dir = START_GRAVITY_DIR
	
	if debug_on:
		debug.visible = true


func _physics_process(delta):
	if has_control:
		inputHelper.get_inputs()

	update_cooldown()

	sm.run_sm(delta)
	
	if inputs.grab:
		if grabRange.is_held:
			grabRange.throw()
		else:
			grabRange.grab_nearest()
	
	self.apply_velocity(delta)
	
	self.take_damage()
	
	if debug_on:
		debug.get_child(0).set_text(str(velocity))
		debug.get_child(1).set_text(str(sm.state_curr))
		pass

	
func apply_velocity(delta):
	var snaps = [Vector2(0, 16), Vector2(16, 0), Vector2(0, -16), Vector2(-16, 0)]
	var floor_normals = [Vector2(0, -1), Vector2(-1, 0), Vector2(0, 1), Vector2(1, 0)]

	if sm.state_curr == "Walljump":
		if ori != -last_velocity_move_sign:
			change_ori(-last_velocity_move_sign)
	else:
		change_ori(sign(input_dir_vector.x))

	if gravity_on:
		velocity_jump = approach(velocity_jump, air_final_speed, gravity)

	match gravity_dir:
		GRAVITY_DIR.DOWN:
			velocity.x = velocity_move
			velocity.y = velocity_jump
		GRAVITY_DIR.RIGHT:
			velocity.y = velocity_move
			velocity.x = velocity_jump
		GRAVITY_DIR.UP:
			velocity.x = velocity_move
			velocity.y =  -velocity_jump
		GRAVITY_DIR.LEFT:
			velocity.y = velocity_move
			velocity.x = -velocity_jump

	velocity = move_and_slide_with_snap(velocity, snaps[gravity_dir], \
		floor_normals[gravity_dir])


func update_cooldown():
	for cd in cooldowns.values():
		cd.value = min(cd.value + 1, cd.max_value)


func change_ori(_ori):
	if(ori != _ori and _ori != 0):
		ori = _ori
		playerBody.scale.x *= -1


func approach(a, b, amount):
	if (a < b):
		a += amount
		if (a > b):
			return b
	else:
		a -= amount
		if(a < b):
			return b
	return a


func take_damage():
	pass
