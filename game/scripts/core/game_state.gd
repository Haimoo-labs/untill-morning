extends Node

## Minimal project foundation state holder.
## Gameplay implementation should expand this in Prototype v0.1.

const STARTING_DAY: int = 1
const TARGET_PROTOTYPE_DAYS: int = 3

var day: int = STARTING_DAY
var food: int = 3
var wood: int = 3
var ammo: int = 6
var gate_hp: int = 100
var last_report: String = ""

func reset() -> void:
	day = STARTING_DAY
	food = 3
	wood = 3
	ammo = 6
	gate_hp = 100
	last_report = ""

func is_prototype_complete() -> bool:
	return day > TARGET_PROTOTYPE_DAYS
