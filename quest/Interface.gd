extends Control


func _ready():
	new_dialog(["Olá!", "Hello Word", "bazuca"])
	pass

func new_dialog(lines):
	$DialogController.new_dialog(lines)
