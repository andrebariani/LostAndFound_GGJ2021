extends Node


var player = null


func init(_entity):
	self.player = _entity


func get_inputs():
	# Reset inputs
	for i in player.inputs.keys():
		player.inputs[i] = 0
	
	player.last_input_dir_vector = player.input_dir_vector
	
	player.input_dir_vector.x = Input.get_action_strength("ui_right") \
								- Input.get_action_strength("ui_left") 
	player.input_dir_vector.y = Input.get_action_strength("ui_down") \
								- Input.get_action_strength("ui_up") 
	
	if Input.is_action_just_pressed("ui_down"):
		player.inputs.grab = 1
	
	if Input.is_action_just_pressed("drop"):
		player.inputs.drop = 1
	
	if Input.is_action_pressed("ui_accept"):
		player.inputs.jump_p = 1
	
	if Input.is_action_just_pressed("ui_accept"):
		player.inputs.jump_jp = 1
	
	if Input.is_action_just_released("ui_accept"):
		player.inputs.jump_jr = 1
	
	if Input.is_action_pressed("sprint"):
		player.inputs.sprint = 1
		
	if Input.is_action_just_pressed("dash") and player.CAN_DASH:
		player.inputs.dash = 1
