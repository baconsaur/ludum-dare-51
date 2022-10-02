extends Control

var pause_menu = preload("res://scenes/PauseMenu.tscn")
var hand_obj = preload("res://scenes/Hand.tscn")
var hand: Control

onready var health_meter = $Health

signal card_selected
signal card_deselected
signal effect_complete

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

func draw_cards(num_cards):
	hand.draw_cards(num_cards)
	emit_signal("effect_complete")

func extend_time(seconds):
	hand.extend_time(seconds)
	emit_signal("effect_complete")

func discard_cards(num_cards):
	hand.discard_cards(num_cards)
	emit_signal("effect_complete")

func update_health(current_health):
	health_meter.text = "Health: " + str(current_health)
