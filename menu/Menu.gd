extends Control

export(Color) var color_inactive = Color('a6a6a6')
export(Color) var color_active = Color('5b5b5b')
export(NodePath) var parent
var menu_offset

func _ready():
	parent = get_node(parent)
	menu_offset = parent.get_child_count()-3
	parent.get_child(menu_offset).set("color", color_inactive)


func _input(event):
	# TOGGLE
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()
	
	# NAVIGATION
	var up = event.is_action_pressed("ui_up")
	var down = event.is_action_pressed("ui_down")
	if (up or down):
		navigation(up, down)
	
	# ACTION
	elif event.is_action_pressed("ui_accept"):
		action()


func navigation(up, _down):
	parent.get_child(menu_offset).set("color", color_active)
	if up:
		if menu_offset == parent.get_child_count()-3:
			menu_offset = parent.get_child_count()-1
		else:
			menu_offset -= 1
	else:
		if menu_offset == parent.get_child_count()-1:
			menu_offset = parent.get_child_count()-3
		else:
			menu_offset += 1
		
	parent.get_child(menu_offset).set("color", color_inactive)


func toggle_pause():
	pass


func action():
	pass
