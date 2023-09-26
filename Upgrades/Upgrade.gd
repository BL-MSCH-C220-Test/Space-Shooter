extends Area2D


func _on_body_entered(body):
	if body.name == "Player":
		body.speed += 2
		body.max_speed += 100
		body.health += 10
		queue_free()


func _on_timer_timeout():
	queue_free()
