extends Node2D

export(PackedScene) var barril
export var delay = 1

func _ready():
	$Delay.start(delay)

func _on_Timer_timeout():
	var new = barril.instance()
	get_parent().add_child(new)
	new.position = position


func _on_Delay_timeout():
	$Timer.start()
