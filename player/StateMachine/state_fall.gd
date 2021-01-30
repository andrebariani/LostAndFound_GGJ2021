extends Node


var stateMachine = null
var p = null


func init():
	pass


func run(_delta):
	var dir = p.input_dir_vector
	
	p.velocity_move = p.approach(p.velocity_move, p.MAX_SPEED * dir.x, p.AIR_ACC)
	p.velocity_jump = p.approach(p.velocity_jump, p.AIR_FINAL_SPEED, p.GRAVITY)
	
	if p.input_jump_jr:
		if(p.velocity_jump  < p.MIN_JUMP*-1):
			p.velocity_jump = p.MIN_JUMP*-1
	
	if p.input_dash:
		p.cd_dash = 0
		stateMachine.change_state("Dash")
	
	if p.is_on_ceiling():
		p.velocity_jump = 0
	
	if p.is_on_floor():
		p.velocity_jump = 0
		if p.velocity_move:
			stateMachine.change_state("Move")
		else:
			stateMachine.change_state("Idle")

