extends CanvasLayer

onready var coin_coint_label = $CoinCountLabel
onready var coin_sound = $CoinSound
onready var coin_pitch : AudioEffectPitchShift = AudioServer.get_bus_effect(1,0)
onready var warning_timer = $WarningTimer
onready var blinker_anim = $PowerUps/AnimationPlayer
onready var ticking_sound = $TickingSound
onready var powerup_box = $PowerUps
onready var world = get_parent()
onready var powerups = {
	"Magnet": $PowerUps/Magnet,
	"Rocket": $PowerUps/Rocket
	# add more powerups here
}

func _ready():
	world.connect("coins_updated",self,"_on_coins_updated")
	world.connect("powerup_changed",self,"_on_powerup_changed")

func _on_coins_updated(new_value):
	coin_coint_label.text = str(new_value).pad_zeros(3)
	coin_pitch.pitch_scale = 0.4 + ((new_value % 50) / 50.0)
	coin_sound.play()
	
func _on_powerup_changed(new_powerup):
	warning_timer.stop()
	ticking_sound.stop()
	blinker_anim.stop()
	var powerup_keys = powerups.keys()
	for powerup in powerup_keys:
		powerups[powerup].visible = (powerup == new_powerup)
	if new_powerup == "":
		powerup_box.visible = false
	else:
		powerup_box.visible = true
		warning_timer.start()

func _on_PowerUpWarningTimer_timeout():
	ticking_sound.play(0.8)
	blinker_anim.play("Blink")
