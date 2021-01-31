extends Area2D


func _on_Checkpoint_body_entered(body):
	if body.name == "Player":
		body.checkpoint_pos = self.global_position
