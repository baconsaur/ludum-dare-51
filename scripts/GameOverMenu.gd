extends Control

export var menu_scene = "res://scenes/MainMenu.tscn"
export var game_scene = "res://scenes/Game.tscn"

onready var score = $MenuContainer/MarginContainer/VBoxContainer/ScoreText


func _ready():
	get_tree().paused = true
	
func _on_RestartButton_pressed():
	get_tree().paused = false
	get_tree().change_scene(game_scene)

func _on_MainMenuButton_pressed():
	get_tree().paused = false
	get_tree().change_scene(menu_scene)

func set_score(points):
	score.text = "Score: " + str(points)
