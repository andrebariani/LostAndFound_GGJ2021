extends Control

export(Texture) var sprite

func _ready():
	new_dialog(["Olá!", "Hello Word", "bazuca"])
	$QuestDisplay.add_pedido(sprite)
	$QuestDisplay.add_pedido(sprite)
	pass

func new_dialog(lines):
	$DialogController.new_dialog(lines)

func add_pedido(_sprite):
	$QuestDisplay.add_pedido(_sprite)
