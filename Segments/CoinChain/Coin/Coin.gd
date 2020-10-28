extends Area2D

var coin_type: String = "Gold" setget set_coin_type
var attractor: Area2D
var velocity := Vector2.ZERO

func _on_Coin_body_entered(body):
	if body.has_method("react_to_coin"):
		body.react_to_coin(coin_type)
		queue_free()

func set_coin_type(new_value):
	# TODO: Implement different coin types
	pass

func _on_Coin_area_entered(area):
	if area.name == "MagneticField":
		attractor = area

func _on_Coin_area_exited(area):
	if area.name == "MagneticField":
		attractor = null

func _process(delta):
	if is_instance_valid(attractor):
		velocity += global_position.direction_to(attractor.global_position).normalized() * 8 * delta
	position += velocity

