extends Node

## Prototype v0.1 GameState. Explicit, minimal state for the day/night survival loop.
## Autoloaded as `GameState` (see project.godot).

enum Phase {
	MORNING,
	EXPEDITION_RESULT,
	EVENING,
	NIGHT_RESULT,
	MORNING_REPORT,
	PROTOTYPE_COMPLETE,
	GAME_OVER,
}

const STARTING_DAY: int = 1
const TARGET_PROTOTYPE_DAYS: int = 3
const MAX_GATE_HP: int = 100
const REPAIR_AMOUNT: int = 20
const REPAIR_WOOD_COST: int = 1

const STARTING_FOOD: int = 3
const STARTING_WOOD: int = 3
const STARTING_AMMO: int = 4

const DAMAGE_BLOCKED_PER_AMMO: int = 10
const MAX_AMMO_AUTO_USED_PER_NIGHT: int = 2

const NIGHT_DAMAGE_BY_DAY: Dictionary = {
	1: 30,
	2: 50,
	3: 80,
}

const FOREST_LOOT_OPTIONS: Array[Dictionary] = [
	{"food": 2, "wood": 1, "ammo": 0},
	{"food": 0, "wood": 2, "ammo": 1},
	{"food": 1, "wood": 0, "ammo": 2},
	{"food": 1, "wood": 1, "ammo": 1},
]

# Core fields
var day: int = STARTING_DAY
var food: int = STARTING_FOOD
var wood: int = STARTING_WOOD
var ammo: int = STARTING_AMMO
var gate_hp: int = MAX_GATE_HP
var phase: Phase = Phase.MORNING

# Expedition result fields
var last_expedition_location: String = ""
var last_loot_food: int = 0
var last_loot_wood: int = 0
var last_loot_ammo: int = 0

# Night result fields
var last_incoming_damage: int = 0
var last_ammo_used: int = 0
var last_damage_blocked: int = 0
var last_gate_damage: int = 0
var last_gate_hp_before: int = 0
var last_gate_hp_after: int = 0

# Repair result fields
var last_wood_used: int = 0
var last_repair_amount: int = 0

# Status fields
var is_game_over: bool = false
var is_prototype_complete: bool = false
var last_report: String = ""


func _ready() -> void:
	reset()


func reset() -> void:
	day = STARTING_DAY
	food = STARTING_FOOD
	wood = STARTING_WOOD
	ammo = STARTING_AMMO
	gate_hp = MAX_GATE_HP
	phase = Phase.MORNING

	last_expedition_location = ""
	last_loot_food = 0
	last_loot_wood = 0
	last_loot_ammo = 0

	last_incoming_damage = 0
	last_ammo_used = 0
	last_damage_blocked = 0
	last_gate_damage = 0
	last_gate_hp_before = 0
	last_gate_hp_after = 0

	last_wood_used = 0
	last_repair_amount = 0

	is_game_over = false
	is_prototype_complete = false
	last_report = ""


func run_forest_expedition() -> void:
	var loot: Dictionary = FOREST_LOOT_OPTIONS[randi() % FOREST_LOOT_OPTIONS.size()]

	last_expedition_location = "Forest"
	last_loot_food = loot["food"]
	last_loot_wood = loot["wood"]
	last_loot_ammo = loot["ammo"]

	food += last_loot_food
	wood += last_loot_wood
	ammo += last_loot_ammo

	phase = Phase.EXPEDITION_RESULT


func continue_to_evening() -> void:
	phase = Phase.EVENING


func repair_gate() -> void:
	last_wood_used = 0
	last_repair_amount = 0

	if wood >= REPAIR_WOOD_COST and gate_hp < MAX_GATE_HP:
		wood -= REPAIR_WOOD_COST
		var repair_amount: int = min(REPAIR_AMOUNT, MAX_GATE_HP - gate_hp)
		gate_hp += repair_amount

		last_wood_used = REPAIR_WOOD_COST
		last_repair_amount = repair_amount

	phase = Phase.EVENING


func start_night() -> void:
	var incoming_damage: int = NIGHT_DAMAGE_BY_DAY.get(day, NIGHT_DAMAGE_BY_DAY[TARGET_PROTOTYPE_DAYS])

	# Integer ceiling division: how many ammo are needed to fully block incoming_damage.
	var ammo_needed: int = (incoming_damage + DAMAGE_BLOCKED_PER_AMMO - 1) / DAMAGE_BLOCKED_PER_AMMO
	var ammo_used: int = min(ammo, min(ammo_needed, MAX_AMMO_AUTO_USED_PER_NIGHT))
	var damage_blocked: int = ammo_used * DAMAGE_BLOCKED_PER_AMMO
	var gate_damage: int = max(0, incoming_damage - damage_blocked)

	var gate_hp_before: int = gate_hp
	ammo -= ammo_used
	gate_hp = max(0, gate_hp - gate_damage)

	last_incoming_damage = incoming_damage
	last_ammo_used = ammo_used
	last_damage_blocked = damage_blocked
	last_gate_damage = gate_damage
	last_gate_hp_before = gate_hp_before
	last_gate_hp_after = gate_hp

	if gate_hp <= 0:
		is_game_over = true
		phase = Phase.GAME_OVER
	else:
		# Food is consumed only on a survived night (BALANCE-TABLE.md).
		food = max(0, food - 1)
		phase = Phase.NIGHT_RESULT


func continue_after_night() -> void:
	if is_game_over:
		phase = Phase.GAME_OVER
		return

	phase = Phase.MORNING_REPORT


func start_next_day() -> void:
	if day >= TARGET_PROTOTYPE_DAYS:
		is_prototype_complete = true
		phase = Phase.PROTOTYPE_COMPLETE
	else:
		day += 1
		phase = Phase.MORNING
