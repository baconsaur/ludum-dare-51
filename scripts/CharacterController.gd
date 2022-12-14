extends Node2D

export var base_speed = 0.4
export var max_health = 3

var is_traveling = false
var next_direction = null

onready var health = max_health
onready var sprite = $AnimatedSprite
onready var last_position = position
onready var target_position = position
onready var move_speed = base_speed
onready var eat_sound = $Eat
onready var heal_sound = $Heal
onready var hurt_sound = $Hurt
onready var pickup_sound = $Pickup
onready var sleep_sound = $Sleep
onready var slow_sound = $Slow
onready var fast_sound = $Fast
onready var die_sound = $Die

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
	if pos.y - position.y > 0:
		sprite.play("run_v")
		sprite.set_flip_v(false)
	elif pos.y - position.y < 0:
		sprite.play("run_v")
		sprite.set_flip_v(true)
	if pos.x - position.x > 0:
		sprite.play("run_h")
		sprite.set_flip_h(true)
	elif pos.x - position.x < 0:
		sprite.play("run_h")
		sprite.set_flip_h(false)

func do_nothing():
	emit_signal("effect_complete")

func rest(seconds, heal_amount):
	sleep_sound.play()
	idle()
	update_health(heal_amount)
	yield(get_tree().create_timer(seconds), "timeout") # TODO add animation
	emit_signal("effect_complete")

func idle():
	if "_h" in sprite.animation:
		sprite.play("idle_h")
	else:
		sprite.play("idle_v")

func take_damage(amount):
	idle()
	update_health(-amount)
	if health <= 0:
		die_sound.play()
		emit_signal("dead")
		return
	hurt_sound.play()
	yield(get_tree().create_timer(0.5), "timeout") # TODO add animation
	emit_signal("effect_complete")

func heal_damage(amount):
	eat_sound.play()
	idle()
	update_health(amount)
	yield(get_tree().create_timer(0.5), "timeout") # TODO add animation
	emit_signal("effect_complete")

func update_health(amount):
	health = clamp(health + amount, 0, max_health)
	emit_signal("update_health")

func get_next_direction():
	var direction = next_direction
	next_direction = null
	return direction

func set_next_direction(direction):
	next_direction = direction
	emit_signal("effect_complete")

func modify_speed(modifier, signal_required=false):
	if modifier > 1:
		fast_sound.play()
	else:
		slow_sound.play()
	idle()
	move_speed = base_speed * modifier
	if signal_required:
		emit_signal("effect_complete")
