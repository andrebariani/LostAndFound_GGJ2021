extends Node


var stateMachine = null
var p = null


func init():
	pass


func run(_delta):
	if not p.is_on_wall():
		p.velocity_move = p.approach(p.velocity_move, 0, p.floor_friction)
	else:
		p.velocity_move = 0
		
	p.floor_jump = false
	
	if p.is_on_floor():
		p.velocity_jump = 0
	
	if p.input_dash:
		p.cooldowns.dash.value = 0
		stateMachine.change_state("Dash")
	elif p.input_dir_vector != Vector2.ZERO:
		stateMachine.change_state("Move")
	elif p.input_jump_jp:
		p.velocity_jump = -p.max_jump
		p.floor_jump = true
		stateMachine.change_state("Air")
	elif not p.is_on_floor():
		p.cooldowns.coyote.value = 0
		stateMachine.change_state("Air")
