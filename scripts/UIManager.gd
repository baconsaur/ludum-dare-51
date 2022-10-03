extends Control

var pause_menu = preload("res://scenes/PauseMenu.tscn")
var hand_obj = preload("res://scenes/Hand.tscn")
var heart_obj = preload("res://scenes/Heart.tscn")
var hand: Control
var hearts = []

onready var health_meter = $Health
onready var score_meter = $Score
onready var speed_modifier_meter = $Speed

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
	var full_hearts = floor(current_health)
	var partial_heart = current_health > full_hearts
	for i in range(hearts.size()):
		if i < full_hearts:
			hearts[i].sprite.play("full")
		elif i == full_hearts and partial_heart:
			hearts[i].sprite.play("half")
		else:
			hearts[i].sprite.play("empty")

func update_score(current_score):
	score_meter.text = "Score: " + str(current_score)

func update_speed_modifier(modifier, countdown):
	if countdown <= 0:
		speed_modifier_meter.text = ""
		return

	var direction = "up" if modifier > 1 else "down"
	speed_modifier_meter.text = "Speed " + str(direction) + " for " + str(stepify(countdown, 0.1)) + " seconds"

func create_health_meter(num_hearts):
	for i in num_hearts:
		var heart = heart_obj.instance()
		health_meter.add_child(heart)
		hearts.append(heart)
