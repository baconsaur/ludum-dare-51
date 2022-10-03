extends Control

export var HAND_SIZE = 5
export var MAX_HAND_SIZE = 9
export var REFRESH_SECONDS = 10

var refresh_countdown = 0
var card_obj = preload("res://scenes/Card.tscn")
var cards = []
var first_hand = true
var key_map = {
	KEY_1: 1,
	KEY_2: 2,
	KEY_3: 3,
	KEY_4: 4,
	KEY_5: 5,
	KEY_6: 6,
	KEY_7: 7,
	KEY_8: 8,
	KEY_9: 9,
}

onready var refresh_meter: Control = $HandContainer/RefreshCountdown
onready var card_container: Control = $HandContainer/CardContainer
onready var card_data = get_node("/root/CardData").card_data

signal card_selected
signal card_deselected

func _ready():
	randomize()
	refresh_hand()
	first_hand = false

func _process(delta):
	refresh_countdown -= delta
	if refresh_countdown <= 0:
		refresh_hand()

	refresh_meter.value = refresh_countdown

func _unhandled_input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		if event.scancode in key_map:
			var key_value = key_map[event.scancode]
			if cards.size() >= key_value:
				cards[key_value - 1].grab_focus()
				cards[key_value - 1].emit_signal("pressed")

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
	add_cards(HAND_SIZE)

func add_cards(num_cards, make_fair=true):
	num_cards = clamp(num_cards, 0, MAX_HAND_SIZE - cards.size())
	var cards_selected = []
	for i in range(num_cards):
		var random_card = randomize_card()
		var random_card_data = card_data[random_card]
		if make_fair:
			if "hand_max" in random_card_data:
				while(not is_fair(random_card, random_card_data, cards_selected)):
					random_card = randomize_card()
					random_card_data = card_data[random_card]
			elif first_hand and random_card == "clear":
				while(random_card == "clear"):
					random_card = randomize_card()
		cards_selected.append(random_card)
	
	for card in cards_selected:
		add_card(card)

func is_fair(name, data, cards_selected):
	if not "hand_max" in data:
		return true
	return cards_selected.count(name) + 1 <= data["hand_max"]

func add_card(random_card):
	var card = card_obj.instance()
	card_container.add_child(card)
	card.connect("pressed", self, "select_card", [card])
	card.connect("played", self, "handle_card_played", [card])
	card.set_type(random_card, card_data[random_card])
	
	cards.append(card)

func draw_cards(num_cards):
	add_cards(num_cards, false)

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
