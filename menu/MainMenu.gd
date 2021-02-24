extends "res://menu/Menu.gd"

onready var menu_options = [$Classico, $Random, $Opcoes, $Sair]
var deactivated = false

func action():
	if deactivated:
		return
	
	match(menu_offset - (parent.get_child_count()-count)):
		0:
			get_tree().change_scene("res://Main.tscn")
		1:
			get_tree().change_scene("res://Main.tscn")
		2:
			for option in menu_options:
				option.set_visible(false)
			deactivated = true
			$MenuOpcoes.visible = true
		3:
			get_tree().quit()


func closed_options():
	for option in menu_options:
		option.set_visible(true)
	deactivated = false
	$MenuOpcoes.visible = false


func _on_MenuOpcoes_return_opcoes():
	closed_options()
