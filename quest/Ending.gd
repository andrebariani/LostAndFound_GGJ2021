extends Control

var _showing = false

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if _showing:
			get_tree().change_scene("res://Main.tscn")


func activate(vitoria, dano, tempo, satisfacao, count, pontuacao):
	_showing = true
	
	if vitoria:
		$Pedidos/Titulo.text = "Vitória!"
	else:
		$Pedidos/Titulo.text = "Fim do Jogo"
	$Pedidos/Vidas.text = "Dano: " + str(dano)
	$Pedidos/Tempo.text = "Tempo: " + str(tempo)
	$Pedidos/Satisfacao.text = "Satisfação: " + str(satisfacao) + "/" + str(count)
	$Pedidos/Pontuacao.text = "Pontuação: " + str(pontuacao)
	$AnimationPlayer.play("activate")
