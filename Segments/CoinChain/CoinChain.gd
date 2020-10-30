extends Path2D
tool

export(int, 100) var coin_interval = 30 setget set_coin_interval
export(String, "Gold", "Silver", "Ruby") var coin_type = "Gold" setget set_coin_type

var coin : PackedScene = preload("res://Segments/CoinChain/Coin/Coin.tscn")

func _ready():
	if !Engine.editor_hint:
		spawn_coins()

func _draw():
	if Engine.editor_hint:
		# Only shown in the editor as indicator during design time. 
		var l = int(curve.get_baked_length())
		var c: Color
		match coin_type:
			"Gold": c = Color(1,1,0)
			"Silver": c = Color(0.8,0.8,0.8)
			"Ruby": c = Color(1,0,0)
		for i in range (0, l, coin_interval):
			draw_circle(curve.interpolate_baked(i), 8, c)

func set_coin_interval(new_value):
	coin_interval = new_value
	update()
	
func set_coin_type(new_value):
	coin_type = new_value
	update()

func spawn_coins():
	var l : int = int(curve.get_baked_length())
	for i in range (0, l, coin_interval):
		var spawn_position = curve.interpolate_baked(i)
		var c = coin.instance()
		add_child(c)
		c.position = spawn_position
		c.coin_type = coin_type
