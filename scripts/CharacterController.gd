extends Node2D

export var move_speed = 0.3

var is_traveling = false

onready var sprite = $AnimatedSprite
onready var last_position = position
onready var target_position = position

signal arrived


func _ready():
	randomize()

func _process(delta):
	if last_position == target_position or not is_traveling:
		return

	if position != target_position:
		var progress = position.distance_to(last_position) / last_position.distance_to(target_position)
		var step = progress + delta * move_speed
		position = lerp(last_position, target_position, step)
		if step > 1 or position.is_equal_approx(target_position):
			position = target_position
			last_position = target_position
			is_traveling = false
			emit_signal("arrived")

func set_initial_position(pos, map_pos):
	position = pos
	last_position = pos

func set_target_position(pos, map_pos):
	target_position = pos
	is_traveling = true
