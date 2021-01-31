extends Node

var spawn_points = []
export(PackedScene) var object_scene
export var clients = []
export(NodePath) var player
var dialog

var total_time = 0
var times = []
var current_obj = 0
var received = 0
var content = 0
var active_quests = []

signal change_sprite
signal new_dialog
signal second_passed
signal endgame


func _ready():
	dialog = [
		[("Aí, filho, o moço trouxe a Suketa. Agora, bebe e fica quietinho, ok?!"), 
		"Eba! Valeu, tio! Mãe, a gente vai pra casa agora?",
		"Não, Roberto! Quantas vezes a mamãe tem que falar que a gente vai visitar a tia Sônia pras festas?",
		"...É melhor você ir tomar seu suco na nave. E fala tchau pro moço!",
		"Tchau, moço!!!"],
		["Finalmente, um parceiro digno de treinamento contra as forças de Lo-Tun!", 
		"...Hm? Ele serve de publicidade? Hah, que piada! Nunca vi um guerreiro com tanta altura e tanto vigor!",
		"Olhe para a faixa na testa dele! Olhe para sua expressão determinada!",
		"Você não vai me enganar, dois-olhos. Este aqui é um lutador nato."],
		["Hm! Roxo, cabeça verde... Será...?", "...", 
		"Droga, não, esse não é meu primo.", "Chapa, pode fazer um favor pra mim?",
		"Se você ver um blob roxo que nem eu com um chapéu verde, avisa ele que o jogo já acabou.",
		"A gente tá jogando pique-esconde já faz 3 meses, e ele não aparece!"],
		["Bzz! Bip-bop!", 
		"O-bri-ga-do, funcionário misterioso! Este bloco é perfeito para minha construção.",
		"Honestamente, as chances de encontrar algo assim em um Posto I-po-ran-ga eram baixas, segundo meus cálculos!", 
		"Mas um sa-ma-ri-ta-no na estrada galática me apontou para cá, então eu vim. BZZZ!",
		"Boas festas, funcionário misterioso!"],
		["Obrigada! Esse era o único disco que faltava pra minha coleção!",
		"...Hm?", "Como eu ouço a música sem ouvidos? Do que você tá falando?",
		"...Espera, isso serve pra TOCAR MÚSICA? Eu pensei que era só pra colecionar!",
		"Bem que eu achei estranho todos eles serem iguais..."],
		["...", "...", "...Hmmm... O-Obrigado, pelo, hmm, queijo?", "...", "...",
		"Eu não sou muito boa em falar com estranhos...", "...", "Quer um pedaço?", "...",
		"...Ah, você não pode comer em serviço? Desculpa...", "...", "...", "Bom... eu vou indo, então.",
		"T-Tchau! Tchauzinho!"],
		["Oooooi! Trouxe o bonsai pra mim?", "...Ah, perfeito! Eu tava tão sozinho no meio da estrada, fugindo dos meus amigos...",
		"Hm? Porque eu tô fugindo? Ah, pique-esconde, é claro!", "...", "O jogo já acabou? QUÊ??? Meu primo falou isso pra você?",
		"Vou voltar pro pique, então! Obrigado, sr. funcionário!"],
		["...", "Essa... Essa não era exatamente o tipo de lâmpada que eu estava procurando, criatura.",
		"...Porém, sob segunda inspeção... hm.", 
		"Essa lâmpada é a que vem com o pacote de só 3 desejos? Ou é a versão Deluxe com todos os 5?",
		"...Só 3? Que ultraje! Nisso que dá fazer negócio com o Aleebaba... Bom, vou levar.",
		"Boa... noite? Dia? Enfim, adeus, criatura."],
		["Oi, trouxe a coxinha pra mim? Aí, valeu.", "...",
		"Aí, deve ser muito louco trabalhar aí durante as festas. Lugar vazio, sossegado... né não?",
		"Mas ao mesmo tempo não é minha praia. Deve ficar chato depois de um tempo. Eu vivo por aventura, arriscar a vida, tá ligado?",
		"E esse seu trabalho... Po, deve ser só ficar confinado aí nessa sala, buscando coxinha... Sem ofensa nem nada, hehe.",
		"Eita, perdi meu horário. Tenho que ir indo, vou fazer crossfit com uma galera.",
		"Falou, cara."],
	]


func new_quest():
	if active_quests.size() >= 3 or current_obj >= 8:
		return
	
	times.append(0)
	active_quests.append(current_obj)
	emit_signal("change_sprite", clients[current_obj])
	current_obj += 1


func receive_order(id):
	if id in active_quests:
		emit_signal("change_sprite", clients[id])
		emit_signal("new_dialog", dialog[id])
		$Timer.stop()
		active_quests.erase(id)
	
	if times[id] <= 120:
		content += 1
	received += 1
	emit_signal("change_sprite", clients[current_obj])


func finalize_order():
	$Timer.start()
	if received >= 9:
		endgame()


func endgame():
	var pontuacao = content*60
	pontuacao -= total_time
	
	#vitoria, vidas, tempo, satisfacao, count, pontuacao
	emit_signal("endgame", true, 0, total_time, content, 9, pontuacao)


func _on_Timer_timeout():
	for i in range(current_obj):
		times[i] += 1
	total_time += 1
	emit_signal("second_passed")
