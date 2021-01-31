extends "res://menu/Menu.gd"

func toggle_pause():
	if !get_tree().paused:
		$AnimationPlayer.play("pause")
	else:
		$AnimationPlayer.play_backwards("pause")
		
	get_tree().paused = !get_tree().paused


func navigation(up, down):
	if !get_tree().paused:
		return
	.navigation(up, down)


func action():
	if !get_tree().paused:
		return
	
	toggle_pause()
	match(menu_offset - ($Pause.get_child_count()-3)):
		1:
			get_tree().change_scene("res://menu/MainMenu.tscn")
		2:
			get_tree().quit()
