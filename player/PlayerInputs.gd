extends Node


var player = null


func init(_entity):
	self.player = _entity


func get_inputs():
	# Reset inputs
	player.input_jump_p = 0
	player.input_jump_jp = 0
	player.input_jump_jr = 0
	player.input_sprint = 0
	player.input_dash = 0
	
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
		player.input_jump_p = 1
	
	if Input.is_action_just_pressed("ui_accept"):
		player.input_jump_jp = 1
	
	if Input.is_action_just_released("ui_accept"):
		player.input_jump_jr = 1
	
	if Input.is_action_pressed("ui_select"):
		player.input_sprint = 1
		
	if Input.is_action_pressed("dash"):
		player.input_dash = 1
	pass
