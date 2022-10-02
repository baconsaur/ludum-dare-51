extends TextureButton

var card_name: String
var play_on: String
var is_selected = false
var visited_bg_sprite = preload("res://sprites/card_background_visited.png")

onready var sprite = $AnimatedSprite

signal played


func set_type(name, data):
	card_name = name
	if "tile_name" in data:
		card_name = data["tile_name"]
	play_on = data["play_on"]
	sprite.play(name)
	if play_on == "visited":
		texture_normal = visited_bg_sprite

func play():
	destroy()
	emit_signal("played")

func destroy():
	# TODO add some juicy discard animation
	disabled = true
	queue_free()

func select():
	is_selected = true
	modulate = Color(1, 1, 0)

func deselect():
	is_selected = false
	modulate = Color(1, 1, 1)
