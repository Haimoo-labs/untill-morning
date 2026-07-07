extends Node2D

## Real-time world controller with the full v0.1 loop:
## day (scavenge + repair) -> night (a day-scaled zombie wave) -> next day,
## ending in Game Over (gate destroyed) or Prototype Complete (3 nights survived).
## Evening/Night are modes of this one scene - no scene reloads mid-run.

const ZOMBIE_SCENE: PackedScene = preload("res://scenes/play/zombie.tscn")
const ZOMBIES_PER_NIGHT: Dictionary = {1: 2, 2: 3, 3: 5}
const SPAWN_STAGGER_SECONDS: float = 1.6
const SPAWN_X_SPREAD: float = 150.0

@onready var player: CharacterBody2D = $Player
@onready var gate: StaticBody2D = $Gate
@onready var zombie_spawn: Marker2D = $ZombieSpawn
@onready var night_overlay: ColorRect = $CanvasLayer/NightOverlay
@onready var joystick: Control = $CanvasLayer/HUD/VirtualJoystick
@onready var fire_button: Button = $CanvasLayer/HUD/FireButton
@onready var repair_button: Button = $CanvasLayer/HUD/RepairButton
@onready var scavenge_button: Button = $CanvasLayer/HUD/ScavengeButton
@onready var start_night_button: Button = $CanvasLayer/HUD/StartNightButton
@onready var restart_button: Button = $CanvasLayer/HUD/RestartButton
@onready var message_label: Label = $CanvasLayer/HUD/MessageLabel
@onready var day_label: Label = $CanvasLayer/HUD/StatsPanel/DayLabel
@onready var food_label: Label = $CanvasLayer/HUD/StatsPanel/FoodLabel
@onready var wood_label: Label = $CanvasLayer/HUD/StatsPanel/WoodLabel
@onready var ammo_label: Label = $CanvasLayer/HUD/StatsPanel/AmmoLabel
@onready var gate_label: Label = $CanvasLayer/HUD/StatsPanel/GateLabel
@onready var shot_sfx: AudioStreamPlayer = $ShotSfx
@onready var hit_sfx: AudioStreamPlayer = $HitSfx
@onready var repair_sfx: AudioStreamPlayer = $RepairSfx
@onready var gate_hit_sfx: AudioStreamPlayer = $GateHitSfx

var is_night: bool = false
var run_over: bool = false
var scavenged_today: bool = false
var _zombies_unresolved: int = 0


func _ready() -> void:
	player.add_to_group("player")
	joystick.direction_changed.connect(player.set_move_direction)
	fire_button.pressed.connect(_on_fire_pressed)
	repair_button.pressed.connect(_on_repair_pressed)
	scavenge_button.pressed.connect(_on_scavenge_pressed)
	start_night_button.pressed.connect(_on_start_night_pressed)
	restart_button.pressed.connect(_on_restart_pressed)
	gate.player_range_changed.connect(_on_gate_range_changed)

	repair_button.visible = false
	restart_button.visible = false
	night_overlay.visible = false
	message_label.text = "Day 1. Scavenge, repair, and hold the gate for 3 nights."
	_refresh_stats()


func _process(_delta: float) -> void:
	_refresh_stats()


func _refresh_stats() -> void:
	day_label.text = "Day %d / %d" % [GameState.day, GameState.TARGET_PROTOTYPE_DAYS]
	food_label.text = "Food: %d" % GameState.food
	wood_label.text = "Wood: %d" % GameState.wood
	ammo_label.text = "Ammo: %d" % GameState.ammo
	gate_label.text = "Gate HP: %d / %d" % [GameState.gate_hp, GameState.MAX_GATE_HP]


func _on_fire_pressed() -> void:
	if run_over:
		return
	var result: String = player.fire()
	match result:
		"fired":
			shot_sfx.play()
		"no_ammo":
			message_label.text = "Out of ammo!"
		"no_target":
			message_label.text = "No zombies in sight - save your ammo."


func _on_gate_range_changed(in_range: bool) -> void:
	repair_button.visible = in_range and not is_night and not run_over \
		and GameState.gate_hp < GameState.MAX_GATE_HP


func _on_repair_pressed() -> void:
	if gate.try_repair():
		repair_sfx.play()
		message_label.text = "Patched the gate. (-1 wood, +%d HP)" % GameState.REPAIR_AMOUNT
	repair_button.visible = gate.player_in_range and GameState.gate_hp < GameState.MAX_GATE_HP


func _on_scavenge_pressed() -> void:
	if is_night or run_over or scavenged_today:
		return
	scavenged_today = true
	scavenge_button.visible = false
	GameState.run_forest_expedition()
	message_label.text = "Scavenged the forest: +%d food, +%d wood, +%d ammo." % [
		GameState.last_loot_food, GameState.last_loot_wood, GameState.last_loot_ammo,
	]


func _on_start_night_pressed() -> void:
	if is_night or run_over:
		return
	is_night = true
	start_night_button.visible = false
	scavenge_button.visible = false
	repair_button.visible = false
	night_overlay.visible = true

	var count: int = ZOMBIES_PER_NIGHT.get(GameState.day, ZOMBIES_PER_NIGHT[GameState.TARGET_PROTOTYPE_DAYS])
	_zombies_unresolved = count
	message_label.text = "Night %d - %d zombies incoming!" % [GameState.day, count]
	_spawn_wave(count)


func _spawn_wave(count: int) -> void:
	for i in range(count):
		if not is_night:
			return
		var zombie := ZOMBIE_SCENE.instantiate()
		add_child(zombie)
		var offset_x: float = randf_range(-SPAWN_X_SPREAD, SPAWN_X_SPREAD)
		zombie.global_position = zombie_spawn.global_position + Vector2(offset_x, randf_range(-40.0, 0.0))
		zombie.target = gate
		zombie.resolved.connect(_on_zombie_resolved)
		zombie.hit.connect(hit_sfx.play)
		if i < count - 1:
			await get_tree().create_timer(SPAWN_STAGGER_SECONDS).timeout


func _on_zombie_resolved(outcome: String) -> void:
	_zombies_unresolved -= 1

	if outcome == "reached_gate":
		gate_hit_sfx.play()
		if GameState.gate_hp <= 0:
			_end_run(false)
			return

	if _zombies_unresolved <= 0 and is_night:
		_night_survived()


func _night_survived() -> void:
	is_night = false
	night_overlay.visible = false

	GameState.advance_after_realtime_night()

	if GameState.is_prototype_complete:
		_end_run(true)
		return

	scavenged_today = false
	scavenge_button.visible = true
	start_night_button.visible = true
	var report := "Night survived! Day %d begins." % GameState.day
	if GameState.food == 0:
		report += " You're out of food."
	message_label.text = report


func _end_run(won: bool) -> void:
	run_over = true
	is_night = false
	night_overlay.visible = false
	start_night_button.visible = false
	scavenge_button.visible = false
	repair_button.visible = false
	restart_button.visible = true
	for zombie in get_tree().get_nodes_in_group("zombies"):
		zombie.queue_free()

	if won:
		message_label.text = "YOU SURVIVED UNTIL MORNING - all %d nights! Prototype complete." % GameState.TARGET_PROTOTYPE_DAYS
	else:
		GameState.is_game_over = true
		message_label.text = "The gate has fallen on night %d. GAME OVER." % GameState.day


func _on_restart_pressed() -> void:
	GameState.reset()
	get_tree().reload_current_scene()
