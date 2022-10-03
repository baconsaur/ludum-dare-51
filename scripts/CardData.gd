extends Node

var card_data = {
	"clearing": {
		"play_on": "empty",
		"weight": 75,
		"points": 1,
		"effect": {
			"type": "character",
			"name": "pass",
			"args": []
		}
	},
	"rest": {
		"play_on": "empty",
		"weight": 20,
		"points": 0,
		"effect": {
			"type": "character",
			"name": "rest",
			"args": [1, 0.5]
		}
	},
	"up": {
		"play_on": "empty",
		"weight": 25,
		"points": 1,
		"effect": {
			"type": "character",
			"name": "force_direction",
			"args": [Vector2(0, -1)]
		}
	},
	"down": {
		"play_on": "empty",
		"weight": 25,
		"points": 1,
		"effect": {
			"type": "character",
			"name": "force_direction",
			"args": [Vector2(0, 1)]
		}
	},
	"left": {
		"play_on": "empty",
		"weight": 25,
		"points": 1,
		"effect": {
			"type": "character",
			"name": "force_direction",
			"args": [Vector2(-1, 0)]
		}
	},
	"right": {
		"play_on": "empty",
		"weight": 25,
		"points": 1,
		"effect": {
			"type": "character",
			"name": "force_direction",
			"args": [Vector2(1, 0)]
		}
	},
	"thorns": {
		"play_on": "empty",
		"hand_max": 3,
		"weight": 40,
		"points": 2,
		"effect": {
			"type": "character",
			"name": "damage",
			"args": [1]
		}
	},
	"food": {
		"play_on": "empty",
		"weight": 15,
		"points": 1,
		"effect": {
			"type": "character",
			"name": "heal",
			"args": [1]
		}
	},
	"draw_1": {
		"play_on": "empty",
		"weight": 10,
		"points": 1,
		"effect": {
			"type": "ui",
			"name": "draw_cards",
			"args": [1]
		}
	},
	"draw_3": {
		"play_on": "empty",
		"weight": 5,
		"points": 1,
		"effect": {
			"type": "ui",
			"name": "draw_cards",
			"args": [3]
		}
	},
	"fast": {
		"play_on": "empty",
		"weight": 10,
		"points": 2,
		"effect": {
			"type": "character",
			"name": "modify_speed",
			"args": [1.25, 10]
		}
	},
	"slow": {
		"play_on": "empty",
		"weight": 10,
		"points": 0,
		"effect": {
			"type": "character",
			"name": "modify_speed",
			"args": [0.75, 10]
		}
	},
	"clear": {
		"play_on": "visited",
		"tile_name": "clearing",
		"weight": 60,
		"points": 1,
		"effect": {
			"type": "character",
			"name": "clear_visited",
			"args": []
		}
	},
#	"extend_time_5": {
#		"weight": 5,
#		"effect": {
#			"type": "ui",
#			"name": "extend_time",
#			"args": [5]
#		}
#	},
#	"discard_hand": {
#		"weight": 5,
#		"effect": {
#			"type": "ui",
#			"name": "discard_cards",
#			"args": [0]
#		}
#	},
}
