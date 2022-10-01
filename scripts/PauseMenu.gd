extends Control

export var menu_scene = "res://scenes/MainMenu.tscn"


func _ready():
	get_tree().paused = true

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		unpause()

func _on_ResumeButton_pressed():
	unpause()

func _on_MainMenuButton_pressed():
	unpause()
	get_tree().change_scene(menu_scene)

func unpause():
	get_tree().paused = false
	queue_free()
