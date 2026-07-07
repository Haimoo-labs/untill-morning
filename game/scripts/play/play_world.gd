extends Node2D

## Real-time proof-of-concept world controller.
## Evening/Night are two modes of this same scene - no scene reload.

const ZOMBIE_SCENE: PackedScene = preload("res://scenes/play/zombie.tscn")

@onready var player: CharacterBody2D = $Player
@onready var gate: StaticBody2D = $Gate
@onready var zombie_spawn: Marker2D = $ZombieSpawn
@onready var night_overlay: ColorRect = $CanvasLayer/NightOverlay
@onready var joystick: Control = $CanvasLayer/HUD/VirtualJoystick
@onready var fire_button: Button = $CanvasLayer/HUD/FireButton
@onready var repair_button: Button = $CanvasLayer/HUD/RepairButton
@onready var start_night_button: Button = $CanvasLayer/HUD/StartNightButton
@onready var message_label: Label = $CanvasLayer/HUD/MessageLabel
@onready var day_label: Label = $CanvasLayer/HUD/StatsPanel/DayLabel
@onready var food_label: Label = $CanvasLayer/HUD/StatsPanel/FoodLabel
@onready var wood_label: Label = $CanvasLayer/HUD/StatsPanel/WoodLabel
@onready var ammo_label: Label = $CanvasLayer/HUD/StatsPanel/AmmoLabel
@onready var gate_label: Label = $CanvasLayer/HUD/StatsPanel/GateLabel

var is_night: bool = false


func _ready() -> void:
	player.add_to_group("player")
	joystick.direction_changed.connect(player.set_move_direction)
	fire_button.pressed.connect(player.fire)
	repair_button.pressed.connect(_on_repair_pressed)
	start_night_button.pressed.connect(_on_start_night_pressed)
	gate.player_range_changed.connect(_on_gate_range_changed)

	repair_button.visible = false
	message_label.text = ""
	night_overlay.visible = false
	_refresh_stats()


func _process(_delta: float) -> void:
	_refresh_stats()


func _refresh_stats() -> void:
	day_label.text = "Day %d / %d" % [GameState.day, GameState.TARGET_PROTOTYPE_DAYS]
	food_label.text = "Food: %d" % GameState.food
	wood_label.text = "Wood: %d" % GameState.wood
	ammo_label.text = "Ammo: %d" % GameState.ammo
	gate_label.text = "Gate HP: %d / %d" % [GameState.gate_hp, GameState.MAX_GATE_HP]


func _on_gate_range_changed(in_range: bool) -> void:
	repair_button.visible = in_range and not is_night and GameState.gate_hp < GameState.MAX_GATE_HP


func _on_repair_pressed() -> void:
	if gate.try_repair():
		repair_button.visible = gate.player_in_range and GameState.gate_hp < GameState.MAX_GATE_HP


func _on_start_night_pressed() -> void:
	if is_night:
		return
	is_night = true
	start_night_button.visible = false
	repair_button.visible = false
	night_overlay.visible = true
	message_label.text = ""

	var zombie := ZOMBIE_SCENE.instantiate()
	get_parent_or_self_container().add_child(zombie)
	zombie.global_position = zombie_spawn.global_position
	zombie.target = gate
	zombie.resolved.connect(_on_night_resolved)


func get_parent_or_self_container() -> Node:
	return self


func _on_night_resolved(outcome: String) -> void:
	is_night = false
	night_overlay.visible = false
	if outcome == "killed":
		message_label.text = "Night survived - the zombie went down before the gate."
	else:
		message_label.text = "The gate took a hit. It's still standing... barely."
	start_night_button.visible = true
