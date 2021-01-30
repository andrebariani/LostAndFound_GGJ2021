extends Node


var stateMachine = null
var p = null


func init():
	pass


func run(_delta):
	var dir = p.input_dir_vector
	
	#if p.cooldowns.air_momentum.value != p.cooldowns.air_momentum.max_value:
	#	if p.cooldowns.air_momentum.value > 8 and dir.x == (-p.last_velocity_move_sign):
	#		p.velocity_move = p.approach(p.velocity_move, p.max_speed * dir.x, p.air_acc)
	#		p.cooldowns.air_momentum.value = p.cooldowns.air_momentum.max_value
	#	else: 
	#		p.velocity_move = p.approach(p.velocity_move, p.max_speed * \
	#								p.last_velocity_move_sign, p.air_acc)
	#else:
	#	p.velocity_move = p.approach(p.velocity_move, p.max_speed * dir.x, p.air_acc)
	
	p.velocity_move = p.approach(p.velocity_move, p.max_speed * dir.x, p.air_acc)
	
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
	elif p.is_on_wall() and p.CAN_WALLJUMP and p.velocity_jump > -90:
		p.velocity_jump = 0
		p.last_velocity_move_sign = sign(p.velocity_move)
		p.cooldowns.walljump.value = 0
		stateMachine.change_state("Walljump")
	elif p.is_on_floor():
		p.velocity_jump = 0
		stateMachine.change_state("Idle")
