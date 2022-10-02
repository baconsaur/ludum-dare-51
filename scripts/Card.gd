extends TextureButton

var card_name: String
var is_selected = false

onready var sprite = $AnimatedSprite

signal played


func set_type(name):
	card_name = name
	sprite.play(name)

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
