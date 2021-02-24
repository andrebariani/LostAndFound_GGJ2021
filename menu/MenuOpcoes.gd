extends Control

signal return_opcoes

func _ready():
	$Nome.text = Global.get_playername()


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		emit_signal("return_opcoes")


func _on_LineEdit_text_changed(new_text):
	Global.set_playername(new_text)


func _on_VolumeSlider_value_changed(value):
	value = value/100 + 0.001
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(value))
