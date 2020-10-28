extends Area2D

func _on_Magnet_body_entered(body):
	if body.has_method("react_to_magnet"):
		body.react_to_magnet()
		queue_free()
