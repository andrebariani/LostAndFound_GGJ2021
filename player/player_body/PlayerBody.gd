extends Node2D

const LEGS_SWITCHER = "parameters/Legs/StateMachine/playback"
const ARMS_SWITCHER = "parameters/Arms/StateMachine/playback"

export (float) var RUN_TRESHOLD := 0.99

export var player: NodePath = "../Player"
onready var player_node = get_node_or_null(player)

onready var body_animation_tree_node = $BodyAnimationTree

func _process(_delta):
	if _player_info_is_valid():
		var animation = _state_to_animation(player_node.sm.state_curr)
		_switch_animation(animation, player_node.is_held())

func _switch_animation(animation_name: String, holding: bool):
	var body_animation: String
	var arm_animation: String
	
	match animation_name:
		"Walljump":
			body_animation = "wall"
			arm_animation = "wall"
		"Air":
			body_animation = "jump"
			arm_animation = "up"
		"AirUp":
			body_animation = "jump"
			arm_animation = "up"
		"AirDown":
			body_animation = "jump"
			arm_animation = "down"
		"Dash":
			body_animation = "wall"
			arm_animation = "back"
		"Idle":
			body_animation = "idle"
			arm_animation = "idle"
		"Move":
			body_animation = "walk"
			arm_animation = "walk"
		"Walk":
			body_animation = "walk"
			arm_animation = "walk"
		"Run":
			body_animation = "run"
			arm_animation = "walk"
	
	_switch_body_animation(body_animation)
	_switch_arm_animation(arm_animation, holding)


func _player_info_is_valid() -> bool:
	return player_node != null and player_node.sm.state_curr != null and player_node.has_method("is_held")


func _switch_body_animation(selected_animation: String) -> void:
	body_animation_tree_node[LEGS_SWITCHER].travel(selected_animation)


func _switch_arm_animation(selected_animation: String, holding: bool) -> void:
	if holding: body_animation_tree_node[ARMS_SWITCHER].travel("arm_hold")
	else: body_animation_tree_node[ARMS_SWITCHER].travel("arm_" + selected_animation)


func _state_to_animation(state_name: String) -> String:
	match state_name:
		"Air":
			if player_node.velocity.y < 0: return "AirUp"
			else: return "AirDown"
		"Move":
			if abs(player_node.velocity.x) < player_node.MAX_SPEED * RUN_TRESHOLD: return "Walk"
			else: return "Run"
	return state_name;
