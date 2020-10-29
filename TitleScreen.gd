extends Node2D

var game_scene: PackedScene = load("res://World.tscn")

func _on_PlayButton_pressed():
	get_tree().change_scene_to(game_scene)
