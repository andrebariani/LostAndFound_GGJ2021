extends Node2D

const LEGS_SWITCHER = "parameters/Legs/StateMachine/playback"
const ARMS_SWITCHER = "parameters/Arms/StateMachine/playback"

export var player: NodePath = "../Player"
onready var player_node = get_node_or_null(player)

onready var body_animation_tree_node = $BodyAnimationTree

func _process(_delta):
	if _player_info_is_valid():
		_switch_animation(player_node.sm.state_curr, player_node.is_held())

func _switch_animation(animation_name: String, holding: bool):
	var selected_animation: String
	
	match animation_name:
		"Walljump", "Air", "Dash":
			selected_animation = "wall"
		"Idle":
			selected_animation = "idle"
		"Move":
			selected_animation = "walk"
	
	body_animation_tree_node[LEGS_SWITCHER].travel(selected_animation)
	
	if holding: body_animation_tree_node[ARMS_SWITCHER].travel("arm_hold")
	else: body_animation_tree_node[ARMS_SWITCHER].travel("arm_" + selected_animation)



func _player_info_is_valid() -> bool:
	return player_node != null and player_node.sm.state_curr != null and player_node.has_method("is_held")
