extends Node

var states = {}
var entity = null
var state_curr = null
var state_next = null
var state_last = null
var node_state


func init(_entity, initial_state:String = "Idle"):
	self.entity = _entity
	var state_nodes = get_children()
	for state_node in state_nodes:
		self.states[state_node.name] = state_node
		state_node.stateMachine = self
		state_node.p = self.entity
	state_next = initial_state
	
	
func run_sm(_delta):
	if state_next != state_curr:
		state_last = state_curr
		state_curr = state_next
		node_state = states[state_curr]
		node_state.init()
		
	node_state.run(_delta)


func change_state(new_state:String):
	print_debug(new_state)
	state_next = new_state
