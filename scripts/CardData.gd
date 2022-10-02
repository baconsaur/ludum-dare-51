extends Node

var card_data = {
	"clearing": {
		"effect": {
			"type": "character",
			"name": "pass",
			"args": []
		}
	},
	"swamp": {
		"effect": {
			"type": "character",
			"name": "delay",
			"args": [1]
		}
	},
	"thorns": {
		"effect": {
			"type": "character",
			"name": "damage",
			"args": [1]
		}
	},
	"food": {
		"effect": {
			"type": "character",
			"name": "heal",
			"args": [1]
		}
	},
	"draw_1": {
		"effect": {
			"type": "ui",
			"name": "draw_cards",
			"args": [1]
		}
	},
	"draw_3": {
		"effect": {
			"type": "ui",
			"name": "draw_cards",
			"args": [3]
		}
	},
	"extend_time_5": {
		"effect": {
			"type": "ui",
			"name": "extend_time",
			"args": [5]
		}
	},
	"discard_hand": {
		"effect": {
			"type": "ui",
			"name": "discard_cards",
			"args": [0]
		}
	},
}
