extends Area3D


func _on_body_entered(body):
	if body is Obstacle:
		body.queue_free()
