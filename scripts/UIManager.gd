extends Control

var pause_menu = preload("res://scenes/PauseMenu.tscn")
var hand_obj = preload("res://scenes/Hand.tscn")
var hand: Control

func _ready():
	create_hand()

func _process(delta):
	if not get_tree().paused and Input.is_action_just_pressed("ui_cancel"):
		var pause_menu_instance = pause_menu.instance()
		add_child(pause_menu_instance)

func create_hand():
	if hand:
		return

	hand = hand_obj.instance()
	add_child(hand)
