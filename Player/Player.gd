extends KinematicBody2D

const GRAVITY = 40
var rocket_boost : float = 0
var speed := Vector2.ZERO

onready var world : Node2D = get_parent()
onready var animation : AnimatedSprite = $AnimatedSprite
onready var magnetic_field : CollisionShape2D = $MagneticField/CollisionShape2D
onready var rocket_fire : Particles2D = $RocketFire
onready var rocket_sound : AudioStreamPlayer = $RocketSound
onready var bouncing_sound : AudioStreamPlayer = $BouncingSound
onready var magnet_sound : AudioStreamPlayer = $MagnetSound

func _ready():
	# magnetic field is disabled by default
	magnetic_field.disabled = true
	world.connect("powerup_changed",self,"_on_powerup_changed")

func _process(delta):
	var target_x: float = get_global_mouse_position().x
	if abs(target_x - position.x) > 1:
		speed.x = clamp((target_x - position.x) / 6, -50, 50)
	speed.y += GRAVITY * delta
	if rocket_boost != 0:
		speed.y = min(speed.y, rocket_boost)
	position += speed
	if position.y > 20:
		position.y = 20
		speed.y = 0
	if speed.y > 40:
		get_tree().change_scene_to(world.title_scene)

func react_to_coin(coin_type):
	# TODO: React differently to different kind of coins
	speed.y = min(speed.y, -20)
	world.coin_count += 1

func react_to_trampoline():
	if speed.y > 0:
		speed.y = -20
		bouncing_sound.play()
		
func react_to_magnet():
	world.active_powerup = "Magnet"

func react_to_rocket():
	world.active_powerup = "Rocket"

func _on_powerup_changed(new_powerup: String):
	match new_powerup:
		"Magnet":
			magnetic_field.set_deferred("disabled", false)
			magnet_sound.play()
			rocket_boost = 0
			rocket_fire.emitting = false
			rocket_sound.stop()
		"Rocket":
			magnetic_field.set_deferred("disabled", true)
			rocket_boost = -15
			rocket_fire.emitting = true
			rocket_sound.play()
		_:
			magnetic_field.set_deferred("disabled", true)
			rocket_boost = 0
			rocket_fire.emitting = false
			rocket_sound.stop()

func _input(event):
	if event.is_action_pressed("ui_select") and position.y > 0:
		speed.y = -50
		animation.play("Flying")
		
