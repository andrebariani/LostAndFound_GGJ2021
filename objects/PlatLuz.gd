extends Node2D

export var activated = false

func _ready():
	set_activated(false)


func toggle():
	set_activated(!activated)


func set_activated(new):
	activated = new
	set_present(new)
	$Timer.paused = !activated
	$Grace.paused = !activated


func set_present(new):
	if !new:
		$TileMap.position.y = 10000
		visible = false
		$Timer.start(1)
	elif activated:
		$TileMap.position.y = 0
		visible = true


func _on_Area2D_body_entered(_body):
	$Grace.start(0.25)

func _on_Timer_timeout():
	set_present(true)

func _on_Grace_timeout():
	set_present(false)
