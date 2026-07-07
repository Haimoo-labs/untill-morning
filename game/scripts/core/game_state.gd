extends Node

## Prototype v0.1 GameState for the real-time day/night survival loop.
## Autoloaded as `GameState` (see project.godot).
##
## Combat outcomes (ammo spent, gate damage) are applied live during play by
## PlayWorld; this holds the run state, the daily loot roll, gate repair, and
## day/completion bookkeeping.

const STARTING_DAY: int = 1
const TARGET_PROTOTYPE_DAYS: int = 3
const MAX_GATE_HP: int = 100
const REPAIR_AMOUNT: int = 20
const REPAIR_WOOD_COST: int = 1

const STARTING_FOOD: int = 1
const STARTING_WOOD: int = 3
const STARTING_AMMO: int = 8

const FOREST_LOOT_OPTIONS: Array[Dictionary] = [
	{"food": 2, "wood": 1, "ammo": 2},
	{"food": 0, "wood": 2, "ammo": 2},
	{"food": 1, "wood": 0, "ammo": 3},
	{"food": 1, "wood": 1, "ammo": 3},
]

# Core fields
var day: int = STARTING_DAY
var food: int = STARTING_FOOD
var wood: int = STARTING_WOOD
var ammo: int = STARTING_AMMO
var gate_hp: int = MAX_GATE_HP

# Expedition result fields
var last_expedition_location: String = ""
var last_loot_food: int = 0
var last_loot_wood: int = 0
var last_loot_ammo: int = 0

# Repair result fields
var last_wood_used: int = 0
var last_repair_amount: int = 0

# Status fields
var is_game_over: bool = false
var is_prototype_complete: bool = false


func _ready() -> void:
	reset()


func reset() -> void:
	day = STARTING_DAY
	food = STARTING_FOOD
	wood = STARTING_WOOD
	ammo = STARTING_AMMO
	gate_hp = MAX_GATE_HP

	last_expedition_location = ""
	last_loot_food = 0
	last_loot_wood = 0
	last_loot_ammo = 0

	last_wood_used = 0
	last_repair_amount = 0

	is_game_over = false
	is_prototype_complete = false


func run_forest_expedition() -> void:
	var loot: Dictionary = FOREST_LOOT_OPTIONS[randi() % FOREST_LOOT_OPTIONS.size()]

	last_expedition_location = "Forest"
	last_loot_food = loot["food"]
	last_loot_wood = loot["wood"]
	last_loot_ammo = loot["ammo"]

	food += last_loot_food
	wood += last_loot_wood
	ammo += last_loot_ammo


func repair_gate() -> void:
	last_wood_used = 0
	last_repair_amount = 0

	if wood >= REPAIR_WOOD_COST and gate_hp < MAX_GATE_HP:
		wood -= REPAIR_WOOD_COST
		var repair_amount: int = min(REPAIR_AMOUNT, MAX_GATE_HP - gate_hp)
		gate_hp += repair_amount

		last_wood_used = REPAIR_WOOD_COST
		last_repair_amount = repair_amount


## Day bookkeeping after a survived real-time night. Food is consumed at
## nightfall by PlayWorld (fed/starving branch), not here.
func advance_after_realtime_night() -> void:
	if day >= TARGET_PROTOTYPE_DAYS:
		is_prototype_complete = true
	else:
		day += 1
