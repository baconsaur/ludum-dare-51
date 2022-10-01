extends Control

export var game_scene = "res://scenes/Game.tscn"


func _on_StartButton_pressed():
	get_tree().change_scene(game_scene)
