extends Node2D

signal powerup_changed (new_powerup)
signal coins_updated (new_value)

onready var powerup_timer = $PowerUpTimer

var current_level_height : float = 0
var coin_count : int = 0 setget set_coin_count
var active_powerup : String = "" setget set_active_powerup

var segments = [
	preload("res://Segments/CurlyChains.tscn"),
	preload("res://Segments/FilledRect.tscn"),
	preload("res://Segments/Trampolins.tscn"),
	preload("res://Segments/CoinsAndRocket.tscn"),
	preload("res://Segments/RandomCoins.tscn"),
	preload("res://Segments/SunCoins.tscn")
	#TODO: Add more segments here
]

func _ready():
	randomize()

func set_coin_count(new_value):
	coin_count = new_value
	emit_signal("coins_updated", coin_count)

func set_active_powerup(new_value):
	active_powerup = new_value
	emit_signal("powerup_changed", new_value)
	powerup_timer.start()

func _process(_delta):
	# delete segments below player	
	for s in $Level.get_children():
		if s.position.y > $Player.position.y + 400:
			s.queue_free()
	# make sure there're enough segments prepared above
	while current_level_height > $Player.position.y - 400:
		add_segment()

func add_segment():
	var s:CoinSegment = segments[randi() % segments.size()].instance()
	$Level.add_child(s)
	current_level_height -= s.segment_height
	s.position = Vector2(s.segment_left, current_level_height)

func _on_PowerUpTimer_timeout():
	set_active_powerup("")
