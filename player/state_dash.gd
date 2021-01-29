extends Node


var stateMachine = null
var p = null


func init():
	p.has_control = false
	p.gravity_on = false
	pass


func run(_delta):
	if not p.is_on_wall():
		p.velocity_move = p.dash_speed*p.ori
	else:
		p.velocity_move = 0
	
	p.velocity_jump = 0
	
	if p.cooldowns.dash.value == p.cooldowns.dash.max_value:
		if p.is_on_floor():
			stateMachine.change_state("Move")
			p.has_control = true
			p.gravity_on = true
		else:
			stateMachine.change_state("Air")
			p.has_control = true
			p.gravity_on = true
