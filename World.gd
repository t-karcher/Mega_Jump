extends Node2D

var speed = 200

var segments = [
	preload("res://Segments/CurlyChains.tscn"),
	preload("res://Segments/FilledRect.tscn")
	#TODO: Add more segments here
]

func _ready():
	randomize()
	init_level()

func _process(delta):
	# fly through the generated level
	# (for demo / visualization only)
	$Player.position.y -= speed * delta
	
func init_level():
	var s:CoinSegment
	var s_offset:float = 0
	# stack 20 random segments
	for _i in range (20):
		s = segments[randi() % segments.size()].instance()
		$Level.add_child(s)
		s_offset -= s.segment_height
		s.position.y = s_offset
	
