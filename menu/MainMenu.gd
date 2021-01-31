extends "res://menu/Menu.gd"


func action():
	match(menu_offset - (parent.get_child_count()-3)):
		0:
			get_tree().change_scene("res://Main.tscn")
		1:
			get_tree().change_scene("res://menu/MainMenu.tscn")
		2:
			get_tree().quit()

