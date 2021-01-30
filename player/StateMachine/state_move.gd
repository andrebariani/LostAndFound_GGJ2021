extends Node


var stateMachine = null
var p = null


func init():
	pass


func run(_delta):
	var dir = p.input_dir_vector
	if p.inputs.sprint:
		p.max_speed = p.MAX_SPEED + 200
	else: 
		p.max_speed = p.MAX_SPEED
	
	p.velocity_move = p.approach(p.velocity_move, p.max_speed * dir.x, p.floor_acc)

	p.floor_jump = false
	
	if p.is_on_floor():
		p.velocity_jump = 0
	
	if p.inputs.dash:
		p.cooldowns.dash.value = 0
		stateMachine.change_state("Dash")
	elif p.inputs.jump_jp:
		p.velocity_jump = -p.max_jump
		p.floor_jump = true
		stateMachine.change_state("Air")
	elif not p.is_on_floor():
		p.cooldowns.coyote.value = 0
		stateMachine.change_state("Air")
	elif dir.x == 0 or p.is_on_wall():
		stateMachine.change_state("Idle")
		
	
