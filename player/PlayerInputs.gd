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
	
	if player.input_dir_vector.y == 1:
		#player.AIR_FINAL_SPEED = 3000
		player.GRAVITY = 60
	
	if player.input_dir_vector.x != 0:
		player.change_ori(player.input_dir_vector.x)
	
	if Input.is_action_pressed("ui_accept"):
		player.inputs.input_jump_p = 1
	
	if Input.is_action_just_pressed("ui_accept"):
		player.inputs.input_jump_jp = 1
	
	if Input.is_action_just_released("ui_accept"):
		player.inputs.input_jump_jr = 1
	
	if Input.is_action_pressed("sprint"):
		player.inputs.input_sprint = 1
		
	if Input.is_action_pressed("dash") and player.CAN_DASH:
		player.inputs.input_dash = 1
	pass
