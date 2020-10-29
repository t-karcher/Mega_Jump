extends Area2D

func _on_Rocket_body_entered(body):
	if body.has_method("react_to_magnet"):
		body.react_to_rocket()
		queue_free()
