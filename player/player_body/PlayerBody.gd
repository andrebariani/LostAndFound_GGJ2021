extends Node2D

const LEGS_SWITCHER = "parameters/Legs/BlendLegs/blend_amount"
const ARMS_SWITCHER = "parameters/Arms/BlendArms/blend_amount"
const HOLD_SWITCHER = "parameters/Arms/BlendHold/blend_amount"

export var player: NodePath = "../Player"
onready var player_node = get_node_or_null(player)

onready var body_animation_tree_node = $BodyAnimationTree

func _process(_delta):
	if _player_info_is_valid():
		_switch_animation(player_node.sm.state_curr, false)

func _switch_animation(animation_name: String, holding: bool):
	match animation_name:
		"Walljump", "Air", "Dash":
			body_animation_tree_node[LEGS_SWITCHER] = -1.0
			body_animation_tree_node[ARMS_SWITCHER] = -1.0
		"Idle":
			body_animation_tree_node[LEGS_SWITCHER] = 0.0
			body_animation_tree_node[ARMS_SWITCHER] = 0.0
		"Move":
			body_animation_tree_node[LEGS_SWITCHER] = 1.0
			body_animation_tree_node[ARMS_SWITCHER] = 1.0
	
	body_animation_tree_node[HOLD_SWITCHER] = 1.0 if holding else 0.0


func _player_info_is_valid() -> bool:
	return player_node != null and player_node.sm.state_curr != null # and player_node.has_method("is_held")
