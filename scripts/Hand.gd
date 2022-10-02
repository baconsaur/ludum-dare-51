extends Control

export var HAND_SIZE = 5
export var REFRESH_SECONDS = 10

var refresh_countdown = 0
var card_obj = preload("res://scenes/Card.tscn")
var cards = []

onready var refresh_meter: Control = $HandContainer/RefreshCountdown
onready var card_container: Control = $HandContainer/CardContainer
onready var card_data = get_node("/root/CardData").card_data

signal card_selected
signal card_deselected

func _ready():
	randomize()
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
	for i in range(HAND_SIZE):
		add_card()

func add_card():
	var card = card_obj.instance()
	card_container.add_child(card)
	card.connect("pressed", self, "select_card", [card])
	card.connect("played", self, "handle_card_played", [card])
	
	var random_card = randomize_card()
	card.set_type(random_card)
	
	cards.append(card)

func draw_cards(num_cards):
	for i in range(num_cards):
		add_card()

func extend_time(seconds):
	refresh_countdown += seconds

func discard_cards(num_cards):
	if num_cards == 0:
		refresh_hand()
	else:
		pass # TODO

func randomize_card():
	var total_card_weight = 0
	for card in card_data:
		total_card_weight += card_data[card]["weight"]
	var roll = randi() % total_card_weight

	for card in card_data:
		roll -= card_data[card]["weight"]
		if roll <= 0:
			return card
