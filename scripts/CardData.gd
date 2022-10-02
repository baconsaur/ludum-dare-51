extends Node

var card_data = {
	"clearing": {
		"weight": 100,
		"effect": {
			"type": "character",
			"name": "pass",
			"args": []
		}
	},
	"swamp": {
		"weight": 50,
		"effect": {
			"type": "character",
			"name": "delay",
			"args": [1]
		}
	},
	"thorns": {
		"weight": 15,
		"effect": {
			"type": "character",
			"name": "damage",
			"args": [1]
		}
	},
	"food": {
		"weight": 15,
		"effect": {
			"type": "character",
			"name": "heal",
			"args": [1]
		}
	},
	"draw_1": {
		"weight": 15,
		"effect": {
			"type": "ui",
			"name": "draw_cards",
			"args": [1]
		}
	},
	"draw_3": {
		"weight": 5,
		"effect": {
			"type": "ui",
			"name": "draw_cards",
			"args": [3]
		}
	},
	"extend_time_5": {
		"weight": 5,
		"effect": {
			"type": "ui",
			"name": "extend_time",
			"args": [5]
		}
	},
	"discard_hand": {
		"weight": 5,
		"effect": {
			"type": "ui",
			"name": "discard_cards",
			"args": [0]
		}
	},
}
