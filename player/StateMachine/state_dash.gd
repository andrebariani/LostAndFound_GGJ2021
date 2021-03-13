extends Node


var stateMachine = null
var p = null


func init():
	p.has_control = false
	p.gravity_on = false
	p.sfx_dash.play()
	pass


func run(_delta):
	p.can_dash = false
	
	if not p.is_on_wall():
		p.velocity_move = p.dash_speed*p.ori
	else:
		p.velocity_move = 0
	
	if !p.in_space:
		p.velocity_jump = 0
	
	if p.is_on_wall():
		p.cooldowns.dash.value = p.cooldowns.dash.max_value
		if p.CAN_WALLJUMP:
			if !p.in_space:
				p.velocity_jump = 0
			p.last_velocity_move_sign = sign(p.velocity_move)
			p.cooldowns.walljump.value = 0
			stateMachine.change_state("Walljump")
		else:
			stateMachine.change_state("Air")
			
		p.has_control = true
		p.gravity_on = true
	elif p.cooldowns.dash.value == p.cooldowns.dash.max_value:
		if p.is_on_floor():
			stateMachine.change_state("Move")
			p.has_control = true
			p.gravity_on = true
		else:
			stateMachine.change_state("Air")
			p.has_control = true
			p.gravity_on = true

