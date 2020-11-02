extends Node2D

signal powerup_changed (new_powerup)
signal coins_updated (new_value)

onready var powerup_timer = $PowerUpTimer
onready var player = $Player
onready var level = $Level
onready var cloud_background = $ParallaxBackground/ParallaxLayer/Clouds

var title_scene: PackedScene = load("res://TitleScreen.tscn")
var current_level_height : float = 0
var coin_count : int = 0 setget set_coin_count
var active_powerup : String = "" setget set_active_powerup

var segments = [
	preload("res://Segments/CurlyChains.tscn"),
	preload("res://Segments/FilledRect.tscn"),
	preload("res://Segments/Trampolins.tscn"),
	preload("res://Segments/CoinsAndRocket.tscn"),
	preload("res://Segments/RandomCoins.tscn"),
	preload("res://Segments/SunCoins.tscn"),
	preload("res://Segments/SimonsSegment.tscn")
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
	for s in level.get_children():
		if s.position.y > player.position.y + 400:
			s.queue_free()
	# make sure there're enough segments prepared above
	while current_level_height > player.position.y - 400:
		var s:CoinSegment = segments[randi() % segments.size()].instance()
		level.add_child(s)
		current_level_height -= s.segment_height
		s.position = Vector2(s.segment_left, current_level_height)
	# fade out clouds when player reaches space
	var fade_start: float = -30000
	var fade_range: float = 16000
	if player.position.y < fade_start:
		var cloud_opacity = (player.position.y - fade_start + fade_range) / fade_range
		cloud_background.modulate.a = cloud_opacity

func _on_PowerUpTimer_timeout():
	set_active_powerup("")
