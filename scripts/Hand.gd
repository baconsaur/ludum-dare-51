extends Control

export var HAND_SIZE = 3
export var REFRESH_SECONDS = 10

var refresh_countdown = 0
var card_obj = preload("res://scenes/Card.tscn")
var card_types = {
	"1": {
		"image_name": "1",
	},
	"2": {
		"image_name": "2",
	},
	"3": {
		"image_name": "3",
	},
	"4": {
		"image_name": "4",
	},
}
var cards = []

onready var refresh_meter: Control = $HandContainer/RefreshCountdown
onready var card_container: Control = $HandContainer/CardContainer

func _ready():
	refresh_hand()

func _process(delta):
	refresh_countdown -= delta
	if refresh_countdown <= 0:
		refresh_hand()

	refresh_meter.value = refresh_countdown

func play_card(card):
	cards.erase(card)
	card.queue_free()

func refresh_hand():
	for card in cards:
		card.queue_free()
	cards = []
	
	refresh_countdown = REFRESH_SECONDS
	for i in HAND_SIZE:
		var card = card_obj.instance()
		card_container.add_child(card)
		card.connect("pressed", self, "play_card", [card])
		
		var card_type = card_types.keys()[randi() % card_types.size()]
		card.set_type(card_types[card_type])
		
		cards.append(card)
