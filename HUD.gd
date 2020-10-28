extends CanvasLayer

onready var coin_coint_label = $CoinCountLabel
onready var world = get_parent()
onready var powerups = {
	"Magnet": $PowerUps/Magnet
	# add more powerups here
}

func _ready():
	world.connect("coins_updated",self,"_on_coins_updated")
	world.connect("powerup_changed",self,"_on_powerup_changed")

func _on_coins_updated(new_value):
	coin_coint_label.text = str(new_value).pad_zeros(3)
	
func _on_powerup_changed(new_powerup):
	var powerup_keys = powerups.keys()
	for powerup in powerup_keys:
		powerups[powerup].visible = (powerup == new_powerup)
