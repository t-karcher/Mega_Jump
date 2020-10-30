extends Node2D

var game_scene: PackedScene = load("res://World.tscn")

func _ready():
	$AudioStreamPlayer.play()

func _on_PlayButton_pressed():
	get_tree().change_scene_to(game_scene)

func _on_ToggleMusicButton_toggled(button_pressed: bool):
	if button_pressed:
		$AudioStreamPlayer.play()
	else:
		$AudioStreamPlayer.stop()
