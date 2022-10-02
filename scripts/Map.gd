extends TileMap

var placeable_tile = null

signal tile_played
signal effect_complete
signal tile_hover
signal tile_unhover


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
