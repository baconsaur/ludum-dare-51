extends Node2D

var selected_card: Control

onready var ui = $CanvasLayer/UI
onready var map = $Map
onready var camera = $Character/Camera2D


func _ready():
	init_map()
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

func init_map():
	var screen_size = get_viewport().size
	var cell_size = map.cell_size.x  # They're square idgaf
	for y in range(-1, screen_size.y / cell_size + 1):
		for x in range(-1, screen_size.x / cell_size + 1):
			var actual_y = y + camera.position.y / cell_size
			if map.get_cell(x, actual_y) == map.INVALID_CELL:
				map.set_cell(x, actual_y, 0)
