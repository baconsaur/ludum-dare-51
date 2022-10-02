extends TileMap

export var padding_tiles = 3

var placeable_tile = null
var bounds_min = Vector2()
var bounds_max = Vector2()

signal tile_played
signal effect_complete
signal tile_hover
signal tile_unhover

onready var padding = padding_tiles * cell_size.x


func allow_placement(tile_name):
	placeable_tile = tile_name

func disallow_placement():
	placeable_tile = null

func _unhandled_input(event):
	if !placeable_tile:
		emit_signal("tile_unhover")
		return

	if event is InputEventMouseButton and event.pressed:
		var pos = world_to_map(get_global_mouse_position())
		if get_cellv(pos) == 0:
			var tile = tile_set.find_tile_by_name(placeable_tile)
			set_cellv(pos, tile)
			emit_signal("tile_played")
	elif event is InputEventMouseMotion:
		var pos = world_to_map(get_global_mouse_position())
		if get_cellv(pos) == 0:
			emit_signal("tile_hover", pos)
		else:
			emit_signal("tile_unhover")

func get_tile_name(pos):
	return tile_set.tile_get_name(get_cellv(pos))

func visit(pos):
	set_cellv(pos, tile_set.find_tile_by_name("visited"))

func is_available_cell(pos):
	if not is_valid_cell(pos):
		return false

	return not is_out_of_bounds(pos)

func is_out_of_bounds(pos):
	return get_cellv(pos) <= 0

func is_valid_cell(pos):
	var tile_index = get_cellv(pos)
	if tile_index == INVALID_CELL:
		return false
	return tile_set.tile_get_name(tile_index) != "visited"

func expand(tile_pos):
	if tile_pos.y - bounds_min.y < padding_tiles:
		add_row(bounds_min.y - 1)
		update_bounds(Vector2(bounds_min.x, bounds_min.y - 1))
	elif tile_pos.x - bounds_min.x < padding_tiles:
		add_col(bounds_min.x - 1)
		update_bounds(Vector2(bounds_min.x - 1, bounds_min.y))
	elif bounds_max.y - tile_pos.y < padding_tiles:
		add_row(bounds_max.y + 1)
		update_bounds(Vector2(bounds_max.x, bounds_max.y + 1))
	elif bounds_max.x - tile_pos.x < padding_tiles:
		add_col(bounds_max.x + 1)
		update_bounds(Vector2(bounds_max.x + 1, bounds_max.y))

func update_bounds(tile_pos):
	bounds_min = Vector2(min(tile_pos.x, bounds_min.x), min(tile_pos.y, bounds_min.y))
	bounds_max = Vector2(max(tile_pos.x, bounds_max.x), max(tile_pos.y, bounds_max.y))

func add_row(y):
	for x in range(bounds_min.x, bounds_max.x + 1):
		set_cell(x, y, 0)

func add_col(x):
	for y in range(bounds_min.y, bounds_max.y + 1):
		set_cell(x, y, 0)
