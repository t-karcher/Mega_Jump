extends Area2D

func _on_Trampoline_body_entered(body):
	if body.has_method("react_to_trampoline"):
		body.react_to_trampoline()
