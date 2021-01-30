extends Control

var _lines = []
var _current_line = ""
var _showing = false

signal dialogo_terminado

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if _showing:
			if $DialogBox/Label.text.length() < _current_line.length():
				$DialogBox/Label.text = _current_line
				$TextScroll.stop()
			else:
				next_dialog()


func new_dialog(lines):
	_lines = lines
	next_dialog()


func next_dialog():
	if _lines.empty():
		$AnimationPlayer.play_backwards("show_dialog")
		_showing = false
		emit_signal("dialogo_terminado")
		return
	
	if !_showing:
		$AnimationPlayer.play("show_dialog")
		_showing = true
	else:
		$DialogBox/Label.text = ""
		_current_line = _lines.front()
		_lines.pop_front()
		$TextScroll.start()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "show_dialog" and _showing:
		next_dialog()


func _on_TextScroll_timeout():
	var text_len = $DialogBox/Label.text.length()
	if text_len >= _current_line.length():
		$TextScroll.stop()
	else:
		$DialogBox/Label.text = _current_line.substr(0, text_len+1)
