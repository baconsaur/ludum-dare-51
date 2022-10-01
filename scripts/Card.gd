extends TextureButton

var card_data: Dictionary
var is_selected = false

onready var sprite = $AnimatedSprite

signal played


func set_data(data):
	card_data = data
	sprite.play(data["sprite_name"])

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
