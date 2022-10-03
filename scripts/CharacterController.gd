extends Node2D

export var base_speed = 0.28
export var max_health = 3

var is_traveling = false
var next_direction = null

onready var health = max_health
onready var sprite = $AnimatedSprite
onready var last_position = position
onready var target_position = position
onready var move_speed = base_speed

signal arrived
signal effect_complete
signal update_health
signal dead


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

func set_initial_position(pos):
	position = pos
	last_position = pos

func set_target_position(pos):
	target_position = pos
	is_traveling = true

func do_nothing():
	emit_signal("effect_complete")

func delay(seconds):
	yield(get_tree().create_timer(seconds), "timeout") # TODO add animation
	emit_signal("effect_complete")

func take_damage(amount):
	health -= amount
	emit_signal("update_health")
	if health <= 0:
		emit_signal("dead")
		return
	yield(get_tree().create_timer(0.5), "timeout") # TODO add animation
	emit_signal("effect_complete")

func heal_damage(amount):
	health = min(health + amount, max_health)
	emit_signal("update_health")
	yield(get_tree().create_timer(0.5), "timeout") # TODO add animation
	emit_signal("effect_complete")

func get_next_direction():
	var direction = next_direction
	next_direction = null
	return direction

func set_next_direction(direction):
	next_direction = direction
	emit_signal("effect_complete")

func modify_speed(modifier, signal_required=false):
	move_speed = base_speed * modifier
	if signal_required:
		emit_signal("effect_complete")
