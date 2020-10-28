extends KinematicBody2D

const GRAVITY = 40
var speed: Vector2 = Vector2.ZERO

onready var world : Node2D = get_parent()
onready var magnetic_field : CollisionShape2D = $MagneticField/CollisionShape2D

func _ready():
	# magnetic field is disabled by default
	magnetic_field.disabled = true
	world.connect("powerup_changed",self,"_on_powerup_changed")

func _process(delta):
	var target_x: float = get_global_mouse_position().x
	if abs(target_x - position.x) > 1:
		speed.x = clamp((target_x - position.x) / 6, -50, 50)
	speed.y += GRAVITY * delta
	position += speed
	if position.y > 20: position.y = 20

func react_to_coin(coin_type):
	speed.y = -20
	world.coin_count += 1

func react_to_trampoline():
	if speed.y >= 0:
		speed.y = -20
		
func react_to_magnet():
	world.active_powerup = "Magnet"

func _on_powerup_changed(new_powerup):
	if new_powerup == "Magnet":
		magnetic_field.set_deferred("disabled", false)
	else:
		magnetic_field.set_deferred("disabled", true)

func _input(event):
	if event.is_action_pressed("ui_select"):
		speed.y = -20
