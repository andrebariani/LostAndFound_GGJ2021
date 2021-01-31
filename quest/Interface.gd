extends Control

export(Texture) var sprite

signal dialogo_terminado

func _ready():
	#new_dialog(["Olá!", "Hello Word", "bazuca"])
	#$QuestDisplay.add_pedido(sprite, 0)
	#$QuestDisplay.add_pedido(sprite, 1)
	pass

func new_dialog(lines):
	$DialogController.new_dialog(lines)

func add_pedido(sprite_, id, area):
	$QuestDisplay.add_pedido(sprite_, id, area)

func delete_pedido(id):
	$QuestDisplay.delete_pedido(id)
	set_item(null)

func set_ferramenta(_sprite):
	$GameUI.set_ferramenta(_sprite)

func set_item(_sprite):
	$GameUI.set_item(_sprite)

func update_rotation(rotation):
	$GameUI.update_rotation(rotation)

func ending(vitoria, vidas, tempo, satisfacao, count, pontuacao):
	$Ending.activate(vitoria, vidas, tempo, satisfacao, count, pontuacao)


func clock():
	$Relogio.relogio()
	$QuestDisplay.clock()


func _on_DialogController_dialogo_terminado():
	emit_signal("dialogo_terminado")

func _on_Player_update_oxygen(porcentagem):
	$GameUI.update_oxigenio(porcentagem)

func _on_Quest_new_pedido(sprite_, id, area):
	add_pedido(sprite_, id, area)

func _on_Quest_new_dialog(lines):
	new_dialog(lines)

func _on_Quest_delete_pedido(id):
	delete_pedido(id)


func _on_Player_update_tool(_sprite):
	set_ferramenta(_sprite)

func _on_Quest_set_item(_sprite):
	set_item(_sprite)


func _on_Quest_update_rotation(rotation):
	update_rotation(rotation-90)
