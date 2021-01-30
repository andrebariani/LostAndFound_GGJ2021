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
onready var debug = $Debug


var max_speed
var gravity
var air_final_speed
var max_jump
var min_jump
var floor_acc
var floor_friction
var air_acc
var dash_speed
var wallslide_speed


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
	input_jump_p = 0,
	input_jump_jp = 0,
	input_jump_jr = 0,
	input_sprint = 0,
	input_dash = 0
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

func _ready():
	max_speed = MAX_SPEED
	gravity = GRAVITY
	air_final_speed = AIR_FINAL_SPEED
	max_jump = MAX_JUMP
	min_jump = MIN_JUMP
	floor_acc = FLOOR_ACC
	floor_friction = FLOOR_FRICTION
	air_acc = AIR_ACC
	dash_speed = DASH_SPEED
	wallslide_speed = WALLSLIDE_SPEED
	
	sm.init(self, "Idle")
	inputHelper.init(self)
	gravity_dir = START_GRAVITY_DIR
	if debug_on:
		debug.visible = true


func _physics_process(delta):
	if has_control:
		inputHelper.get_inputs()

	update_cooldown()

	sm.run_sm(delta)
	
	self.apply_velocity()
	
	if debug_on:
		debug.get_child(0).set_text(str(velocity))
		debug.get_child(1).set_text(str(sm.state_curr))
		pass

	
func apply_velocity():
	var snaps = [Vector2(0, 31), Vector2(31, 0), Vector2(0, -31), Vector2(31, 0)]
	var floor_normals = [Vector2(0, -1), Vector2(-1, 0), Vector2(0, 1), Vector2(1, 0)]

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

	velocity = move_and_slide(velocity, floor_normals[gravity_dir])


func update_cooldown():
	for cd in cooldowns.values():
		cd.value = min(cd.value + 1, cd.max_value)


func change_ori(_ori):
	if(ori != _ori and _ori != 0):
		ori = _ori


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
