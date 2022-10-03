extends TextureButton

export var icon_offset = 26

var card_name: String
var play_on: String
var is_selected = false

onready var sprite = $AnimatedSprite
onready var sprite_start_y = sprite.position.y

signal played


func set_type(name, data):
	card_name = name
	if "tile_name" in data:
		card_name = data["tile_name"]
	play_on = data["play_on"]
	sprite.play(name)

func play():
	destroy()
	emit_signal("played")

func destroy():
	# TODO add some juicy discard animation
	disabled = true
	queue_free()

func select():
	sprite.position.y = sprite_start_y - icon_offset
	is_selected = true

func deselect():
	sprite.position.y = sprite_start_y
	is_selected = false

func _on_Card_mouse_entered():
	if is_selected:
		return
	sprite.position.y = sprite_start_y - icon_offset

func _on_Card_mouse_exited():
	if is_selected:
		return
	sprite.position.y = sprite_start_y
