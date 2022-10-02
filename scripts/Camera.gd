extends Camera2D

export var move_speed = 100
export var follow_offset = Vector2(0, 80)

var follow_target
var follow_mode = true


func _process(delta):
	if follow_mode and follow_target:
		position = follow_target.position + follow_offset
	
	var move_x = 0
	var move_y = 0
	if Input.is_action_pressed("ui_left"):
		move_x = -1
	if Input.is_action_pressed("ui_right"):
		move_x = 1
	if Input.is_action_pressed("ui_down"):
		move_y = 1
	if Input.is_action_pressed("ui_up"):
		move_y = -1
	
	if move_x or move_y:
		follow_mode = false
		position.y += move_y * delta * move_speed
		position.x += move_x * delta * move_speed
	
	if Input.is_action_pressed("ui_accept"):
		follow_mode = true
		# TODO slide transition
