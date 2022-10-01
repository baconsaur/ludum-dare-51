extends Control

var pause_menu = preload("res://scenes/PauseMenu.tscn")
var hand_obj = preload("res://scenes/Hand.tscn")
var hand: Control

signal card_selected
signal card_deselected

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
	hand.connect("card_selected", self, "handle_card_select")
	hand.connect("card_deselected", self, "handle_card_deselect")

func handle_card_select(card):
	emit_signal("card_selected", card)

func handle_card_deselect():
	emit_signal("card_deselected")
