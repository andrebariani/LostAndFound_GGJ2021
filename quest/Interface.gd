extends Control

export(Texture) var sprite

func _ready():
	new_dialog(["Olá!", "Hello Word", "bazuca"])
	$QuestDisplay.add_pedido(sprite, 0)
	$QuestDisplay.add_pedido(sprite, 1)
	pass

func new_dialog(lines):
	$DialogController.new_dialog(lines)

func add_pedido(sprite_, id):
	$QuestDisplay.add_pedido(sprite_, id)

func delete_pedido(id):
	$QuestDisplay.delete_pedido(id)

func ending(vitoria, vidas, tempo, satisfacao, count, pontuacao):
	$Ending.activate(vitoria, vidas, tempo, satisfacao, count, pontuacao)


func clock():
	$Relogio.clock()
	$QuestDisplay.clock()
