extends Node2D
class_name CoinSegment

onready var segment_height: float = $LowerRightCorner.position.y
onready var segment_left: float = -$LowerRightCorner.position.x / 2
