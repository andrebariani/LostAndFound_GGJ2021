extends Node


var stateMachine = null
var p = null


func init():
	pass


func run(_delta):
	var dir = p.input_dir_vector
	
	p.velocity_move = p.approach(p.velocity_move, p.max_speed * dir.x, p.air_acc)
	
	if p.input_jump_jp:
		if p.cooldowns.coyote.value < p.cooldowns.coyote.max_value:
			p.velocity_jump = -p.max_jump
	
	if p.input_jump_jr:
		if(p.velocity_jump  < p.min_jump*-1):
			p.velocity_jump = p.min_jump*-1
	
	if p.input_dash:
		p.cooldowns.dash.value = 0
		stateMachine.change_state("Dash")
	
	if p.is_on_ceiling():
		p.velocity_jump = 0
	
	if p.is_on_floor():
		p.velocity_jump = 0
		stateMachine.change_state("Idle")
