extends Node


var stateMachine = null
var p = null


func init():
	pass


func run(_delta):
	var dir = p.input_dir_vector
	
	if !p.is_on_wall():
		if p.inputs.input_sprint:
			p.velocity_move = p.approach(p.velocity_move, (p.max_speed + 200) * dir.x, p.air_acc)
		else: 
			p.velocity_move = p.approach(p.velocity_move, p.max_speed * dir.x, p.air_acc)
	else:
		p.velocity_move = 0
	
	if p.inputs.input_jump_jp:
		if p.cooldowns.coyote.value < p.cooldowns.coyote.max_value:
			p.velocity_jump = -p.max_jump
	
	if p.inputs.input_jump_jr:
		if(p.velocity_jump  < p.min_jump*-1):
			p.velocity_jump = p.min_jump*-1
	
	if p.is_on_ceiling():
		p.velocity_jump = 0
	
	if p.inputs.input_dash:
		p.cooldowns.dash.value = 0
		stateMachine.change_state("Dash")
	#elif p.is_on_wall() and p.CAN_WALLJUMP and p.velocity_jump > -90:
	#	p.velocity_jump = 0
	#	p.last_velocity_move_sign = sign(p.velocity_move)
	#	p.cooldowns.walljump.value = 0
	#	stateMachine.change_state("Walljump")
	elif p.is_on_floor():
		p.velocity_jump = 0
		stateMachine.change_state("Idle")
