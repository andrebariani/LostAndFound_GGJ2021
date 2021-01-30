extends Control

const ox_max = 225

func _ready():
	update_oxigenio(0.4)


func set_ferramenta(sprite):
	$Ferramenta.texture = sprite


func set_item(sprite):
	$Item.texture = sprite


func set_health(health):
	for i in range(0, health):
		$Health.get_child(i).visible = true
	
	for i in range(health, 5):
		$Health.get_child(i).visible = false


func update_oxigenio(porcentagem):
	if porcentagem == 1:
		$AnimationPlayer.play("hide")
	elif modulate.a == 0:
		$AnimationPlayer.play("show")
	
	$Pedidos/Meter.rect_size = Vector2(30, ox_max*porcentagem)
	$Pedidos/Meter.rect_position = Vector2(3, 3 + ox_max*(1-porcentagem) )
