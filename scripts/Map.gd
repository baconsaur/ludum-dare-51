extends TileMap

var placeable_tile = null

signal tile_played


func allow_placement(tile_name):
	placeable_tile = tile_name

func disallow_placement():
	placeable_tile = null

func _input(event):
	if !placeable_tile:
		return

	if event is InputEventMouseButton and event.pressed:
		var pos = world_to_map(get_global_mouse_position())
		if get_cellv(pos) == 0:
			var tile = tile_set.find_tile_by_name(placeable_tile)
			set_cellv(pos, tile)
			emit_signal("tile_played")

func visit(pos):
	var tile_name = tile_set.tile_get_name(get_cellv(pos))
	set_cellv(pos, tile_set.find_tile_by_name(tile_name + " visited"))

func is_valid_cell(pos):
	if "visited" in tile_set.tile_get_name(get_cellv(pos)):
		return false

	return not is_out_of_bounds(pos)

func is_out_of_bounds(pos):
	return get_cellv(pos) <= 0
