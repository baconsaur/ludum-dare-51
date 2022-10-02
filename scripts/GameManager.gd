extends Node2D

export var character_cursor_color = Color("#c57835")
export var player_cursor_color = Color("#2f4c6c")

var selected_card: Control
var all_directions = [Vector2(0, 1), Vector2(1, 0), Vector2(-1, 0), Vector2(0, -1)]
var cursor_obj = preload("res://scenes/Cursor.tscn")
var character_cursor = null
var player_cursor = null

onready var ui = $CanvasLayer/UI
onready var map = $Map
onready var character = $Character
onready var camera = $Character/Camera2D
onready var map_offset = map.cell_size / 2
onready var card_data = get_node("/root/CardData").card_data


func _ready():
	init_map()
	character.connect("arrived", self, "handle_character_arrived")
	character.connect("update_health", self, "handle_update_health")
	character.connect("dead", self, "handle_death")
	map.connect("tile_played", self, "handle_tile_played")
	map.connect("tile_hover", self, "handle_tile_hover")
	map.connect("tile_unhover", self, "handle_tile_unhover")
	ui.connect("card_selected", self, "handle_card_select")
	ui.connect("card_deselected", self, "handle_card_deselect")
	handle_update_health()

func handle_card_select(card):
	selected_card = card
	map.allow_placement(card.card_name)

func handle_card_deselect():
	selected_card = null
	map.disallow_placement()

func handle_tile_played():
	map.disallow_placement()
	selected_card.play()

func handle_character_arrived():
	remove_cursor(character_cursor)
	var map_pos = local_to_map(character.position)
	if not map.is_available_cell(map_pos):
		end_game()
	else:
		start_tile_effect(map_pos)

func init_map():
	var screen_size = get_viewport().size
	var cell_size = map.cell_size.x
	for y in range(-1, screen_size.y + camera.position.y + cell_size, cell_size):
		for x in range(-1, screen_size.x + cell_size, cell_size):
			var tile_pos = local_to_map(Vector2(x, y))
			if map.get_cell(tile_pos.x, tile_pos.y) == map.INVALID_CELL:
				map.set_cell(tile_pos.x, tile_pos.y, 0)
			else:
				init_character(Vector2(tile_pos.x, tile_pos.y))

func init_character(map_pos):
	map.visit(map_pos)
	character.set_initial_position(map_to_local(map_pos))
	move_character()

func move_character():
	var available_directions = []
	var valid_directions = []
	var map_position = local_to_map(character.last_position)
	for direction in all_directions:
		if map.is_available_cell(map_position + direction):
			available_directions.append(direction)
		elif map.is_valid_cell(map_position + direction):
			valid_directions.append(direction)

	if available_directions.empty():
		if valid_directions.empty():
			available_directions = all_directions
		else:
			available_directions = valid_directions

	var direction = available_directions[randi() % available_directions.size()]
	var target_map_position = map_position + direction

	var local_target_position = map_to_local(target_map_position)
	character.set_target_position(local_target_position)
	character_cursor = add_cursor(local_target_position, character_cursor_color)

func map_to_local(map_pos):
	return map.map_to_world(map_pos) + map_offset

func local_to_map(pos):
	return map.world_to_map(pos)

func start_tile_effect(tile_pos):
	var tile_effect = card_data[map.get_tile_name(tile_pos)]["effect"]
	var signal_obj = null
	match tile_effect["type"]:
		"ui":
			signal_obj = ui
		"character":
			signal_obj = character
		"map":
			signal_obj = map
	if signal_obj:
		signal_obj.connect("effect_complete", self, "finish_tile_effect", [tile_pos], CONNECT_ONESHOT)
	callv("effect_" + tile_effect["name"], tile_effect["args"])

func finish_tile_effect(tile_pos):
	map.visit(tile_pos)
	move_character()

############# START TILE EFFECTS #############

func effect_pass():
	character.do_nothing()

func effect_delay(delay):
	character.delay(delay)

func effect_damage(amount):
	character.take_damage(amount)

func effect_heal(amount):
	character.heal_damage(amount)

func effect_draw_cards(num_cards):
	ui.draw_cards(num_cards)

func effect_extend_time(seconds):
	ui.extend_time(seconds)

func effect_discard_cards(num_cards):
	ui.discard_cards(num_cards)
	
############# END TILE EFFECTS #############

func handle_update_health():
	ui.update_health(character.health)

func handle_death():
	end_game()
	
func end_game():
	get_tree().reload_current_scene()

func add_cursor(pos, color):
	var cursor = cursor_obj.instance()
	add_child(cursor)
	cursor.position = pos
	cursor.modulate = color
	return cursor

func remove_cursor(cursor):
	if is_instance_valid(cursor):
		cursor.queue_free()

func handle_tile_hover(tile_pos):
	remove_cursor(player_cursor)
	player_cursor = add_cursor(map_to_local(tile_pos), player_cursor_color)

func handle_tile_unhover():
	remove_cursor(player_cursor)
