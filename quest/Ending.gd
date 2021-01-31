extends Control

func activate(vitoria, dano, tempo, satisfacao, count, pontuacao):
	if vitoria:
		$Pedidos/Titulo.text = "Vitória!"
	else:
		$Pedidos/Titulo.text = "Fim do Jogo"
	$Pedidos/Vidas.text = "Dano: " + str(dano)
	$Pedidos/Tempo.text = "Tempo: " + str(tempo)
	$Pedidos/Satisfacao.text = "Satisfação: " + str(satisfacao) + "/" + str(count)
	$Pedidos/Pontuacao.text = "Pontuação: " + str(pontuacao)
	$AnimationPlayer.play("activate")
	
