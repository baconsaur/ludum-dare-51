extends Node


var CARD_DATA = {
	"1": {
		"tile_name": "clearing 1",
	},
	"2": {
		"tile_name": "clearing 2",
	},
	"3": {
		"tile_name": "clearing 3",
	},
	"4": {
		"tile_name": "clearing 4",
	},
}

func get_card_names():
	return CARD_DATA.keys()

func get_card(key):
	return CARD_DATA[key]
