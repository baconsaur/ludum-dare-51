extends Node

var card_data = {
	"clearing": {
		"weight": 75,
		"points": 1,
		"effect": {
			"type": "character",
			"name": "pass",
			"args": []
		}
	},
	"swamp": {
		"weight": 20,
		"points": 0,
		"effect": {
			"type": "character",
			"name": "delay",
			"args": [1]
		}
	},
	"up": {
		"weight": 25,
		"points": 1,
		"effect": {
			"type": "character",
			"name": "force_direction",
			"args": [Vector2(0, -1)]
		}
	},
	"down": {
		"weight": 25,
		"points": 1,
		"effect": {
			"type": "character",
			"name": "force_direction",
			"args": [Vector2(0, 1)]
		}
	},
	"left": {
		"weight": 25,
		"points": 1,
		"effect": {
			"type": "character",
			"name": "force_direction",
			"args": [Vector2(-1, 0)]
		}
	},
	"right": {
		"weight": 25,
		"points": 1,
		"effect": {
			"type": "character",
			"name": "force_direction",
			"args": [Vector2(1, 0)]
		}
	},
	"thorns": {
		"weight": 30,
		"points": 2,
		"effect": {
			"type": "character",
			"name": "damage",
			"args": [1]
		}
	},
	"food": {
		"weight": 15,
		"points": 1,
		"effect": {
			"type": "character",
			"name": "heal",
			"args": [1]
		}
	},
	"draw_1": {
		"weight": 10,
		"points": 1,
		"effect": {
			"type": "ui",
			"name": "draw_cards",
			"args": [1]
		}
	},
	"draw_3": {
		"weight": 5,
		"points": 1,
		"effect": {
			"type": "ui",
			"name": "draw_cards",
			"args": [3]
		}
	},
	"fast": {
		"weight": 10,
		"points": 2,
		"effect": {
			"type": "character",
			"name": "modify_speed",
			"args": [1.25, 10]
		}
	},
	"slow": {
		"weight": 10,
		"points": 0,
		"effect": {
			"type": "character",
			"name": "modify_speed",
			"args": [0.75, 10]
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
