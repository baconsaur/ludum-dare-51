extends Node2D

var selected_card: Control
var all_directions = [Vector2(0, 1), Vector2(1, 0), Vector2(-1, 0), Vector2(0, -1)]

onready var ui = $CanvasLayer/UI
onready var map = $Map
onready var character = $Character
onready var camera = $Character/Camera2D
onready var map_offset = map.cell_size / 2


func _ready():
	init_map()
	character.connect("arrived", self, "handle_character_arrived")
	map.connect("tile_played", self, "handle_tile_played")
	ui.connect("card_selected", self, "handle_card_select")
	ui.connect("card_deselected", self, "handle_card_deselect")

func handle_card_select(card):
	selected_card = card
	map.allow_placement(card.card_data.tile_name)

func handle_card_deselect():
	selected_card = null
	map.disallow_placement()

func handle_tile_played():
	map.disallow_placement()
	selected_card.play()

func handle_character_arrived():
	var map_pos = local_to_map(character.position)
	if map.is_out_of_bounds(map_pos):
		end_game()
		return
	map.visit(map_pos)
	move_character()

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
	character.set_initial_position(map_to_local(map_pos), map_pos)
	move_character()

func move_character():
	var directions_available = []
	var map_position = local_to_map(character.last_position)
	for direction in all_directions:
		if map.is_valid_cell(map_position + direction):
			directions_available.append(direction)

	if directions_available.empty():
		directions_available = all_directions # TODO prefer out of bounds tiles over visited

	var direction = directions_available[randi() % directions_available.size()]
	var target_map_position = map_position + direction

	character.set_target_position(map_to_local(target_map_position), target_map_position)

func map_to_local(map_pos):
	return map.map_to_world(map_pos) + map_offset

func local_to_map(pos):
	return map.world_to_map(pos)

func end_game():
	get_tree().reload_current_scene()
