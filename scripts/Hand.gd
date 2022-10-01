extends Control

export var HAND_SIZE = 5
export var REFRESH_SECONDS = 10

var refresh_countdown = 0
var card_obj = preload("res://scenes/Card.tscn")
var card_data = [
	{
		"sprite_name": "1",
		"tile_name": "clearing 1",
	},
	{
		"sprite_name": "2",
		"tile_name": "clearing 2",
	},
	{
		"sprite_name": "3",
		"tile_name": "clearing 3",
	},
	{
		"sprite_name": "4",
		"tile_name": "clearing 4",
	},
]
var cards = []

onready var refresh_meter: Control = $HandContainer/RefreshCountdown
onready var card_container: Control = $HandContainer/CardContainer

signal card_selected
signal card_deselected

func _ready():
	refresh_hand()

func _process(delta):
	refresh_countdown -= delta
	if refresh_countdown <= 0:
		refresh_hand()

	refresh_meter.value = refresh_countdown

func handle_card_played(card):
	cards.erase(card)

func select_card(card):
	if card.is_selected:
		card.deselect()
		emit_signal("card_deselected")
		return

	for other_card in cards:
		other_card.deselect()
	card.select()
	emit_signal("card_selected", card)

func refresh_hand():
	emit_signal("card_deselected")
	
	for card in cards:
		card.destroy()
	cards = []
	
	refresh_countdown = REFRESH_SECONDS
	for i in HAND_SIZE:
		var card = card_obj.instance()
		card_container.add_child(card)
		card.connect("pressed", self, "select_card", [card])
		card.connect("played", self, "handle_card_played", [card])
		
		var random_card_data = card_data[randi() % card_data.size()]
		card.set_data(random_card_data)
		
		cards.append(card)
