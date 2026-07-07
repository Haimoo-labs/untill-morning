extends Node2D

## Last-stand turret defence (night-redesign spec): the watchman is anchored
## behind the gate, nights are a countdown to dawn with scheduled spawns,
## taps fire aimed shots, and holding REPAIR channels wood into the gate
## while locking out shooting. Survive 3 nights; a breached gate turns the
## horde onto the player.

const ZOMBIE_SCENE: PackedScene = preload("res://scenes/play/zombie.tscn")

const NIGHT_DURATION: Dictionary = {1: 45.0, 2: 60.0, 3: 75.0}
const ZOMBIES_PER_NIGHT: Dictionary = {1: 4, 2: 6, 3: 7}
const SPAWN_SCHEDULE: Dictionary = {
	1: [0.0, 8.0, 16.0, 24.0],
	2: [0.0, 6.0, 12.0, 20.0, 28.0, 36.0],
	3: [0.0, 6.0, 12.0, 19.0, 26.0, 34.0, 42.0],
}
const SPEED_BY_NIGHT: Dictionary = {1: 45.0, 2: 55.0, 3: 65.0}
const SPAWN_X_SPREAD: float = 160.0

const FIRE_COOLDOWN_FED: float = 0.35
const FIRE_COOLDOWN_STARVING: float = 0.70
const REPAIR_CHANNEL_FED: float = 1.5
const REPAIR_CHANNEL_STARVING: float = 2.5
const REPAIR_RANGE: float = 240.0

@onready var player: CharacterBody2D = $Player
@onready var gate: StaticBody2D = $Gate
@onready var zombie_spawn: Marker2D = $ZombieSpawn
@onready var night_overlay: ColorRect = $CanvasLayer/NightOverlay
@onready var joystick: Control = $CanvasLayer/HUD/VirtualJoystick
@onready var aim_catcher: Control = $CanvasLayer/HUD/AimCatcher
@onready var repair_button: Button = $CanvasLayer/HUD/RepairButton
@onready var repair_progress: ColorRect = $CanvasLayer/HUD/RepairProgress
@onready var scavenge_button: Button = $CanvasLayer/HUD/ScavengeButton
@onready var start_night_button: Button = $CanvasLayer/HUD/StartNightButton
@onready var restart_button: Button = $CanvasLayer/HUD/RestartButton
@onready var message_label: Label = $CanvasLayer/HUD/MessageLabel
@onready var day_label: Label = $CanvasLayer/HUD/DayLabel
@onready var ammo_label: Label = $CanvasLayer/HUD/AmmoLabel
@onready var food_label: Label = $CanvasLayer/HUD/FoodLabel
@onready var wood_label: Label = $CanvasLayer/HUD/WoodLabel
@onready var gate_bar_fill: ColorRect = $CanvasLayer/HUD/GateBarFill
@onready var gate_label: Label = $CanvasLayer/HUD/GateLabel
@onready var shot_sfx: AudioStreamPlayer = $ShotSfx
@onready var hit_sfx: AudioStreamPlayer = $HitSfx
@onready var repair_sfx: AudioStreamPlayer = $RepairSfx
@onready var gate_hit_sfx: AudioStreamPlayer = $GateHitSfx

const GATE_BAR_FULL_WIDTH: float = 330.0

var is_night: bool = false
var run_over: bool = false
var breached: bool = false
var scavenged_today: bool = false
var starving: bool = false

var night_time: float = 0.0
var _night_elapsed: float = 0.0
var _spawn_queue: Array = []

var _channel_active: bool = false
var _channel_left: float = 0.0
var _channel_duration: float = REPAIR_CHANNEL_FED


func _ready() -> void:
	player.add_to_group("player")
	joystick.direction_changed.connect(player.set_move_direction)
	aim_catcher.gui_input.connect(_on_aim_input)
	repair_button.button_down.connect(_on_repair_hold_started)
	repair_button.button_up.connect(_on_repair_hold_released)
	scavenge_button.pressed.connect(_on_scavenge_pressed)
	start_night_button.pressed.connect(_on_start_night_pressed)
	restart_button.pressed.connect(_on_restart_pressed)

	restart_button.visible = false
	night_overlay.visible = false
	repair_progress.visible = false
	message_label.text = "Day 1. Scavenge, repair, and hold the gate for 3 nights. Tap zombies to shoot."
	_refresh_hud()


func _process(delta: float) -> void:
	_refresh_hud()
	_advance_channel(delta)

	if not is_night or run_over:
		return

	night_time -= delta
	_night_elapsed = NIGHT_DURATION[GameState.day] - night_time

	while not _spawn_queue.is_empty() and _night_elapsed >= _spawn_queue[0]:
		_spawn_queue.pop_front()
		_spawn_zombie()

	if not breached and GameState.gate_hp <= 0:
		_trigger_breach()

	# Dawn saves you even mid-breach - if you can outrun the horde until
	# morning, you live (the gate is still wreckage to rebuild).
	if night_time <= 0.0:
		_dawn()


func _refresh_hud() -> void:
	day_label.text = "Day %d / %d" % [GameState.day, GameState.TARGET_PROTOTYPE_DAYS]
	ammo_label.text = "Ammo: %d" % GameState.ammo
	wood_label.text = "Wood: %d" % GameState.wood
	if is_night:
		food_label.text = "STARVING" if starving else "Fed"
	else:
		food_label.text = "Food: %d" % GameState.food

	var ratio: float = float(GameState.gate_hp) / float(GameState.MAX_GATE_HP)
	gate_bar_fill.size.x = GATE_BAR_FULL_WIDTH * ratio
	gate_bar_fill.color = Color(0.85, 0.25, 0.2).lerp(Color(0.35, 0.7, 0.3), ratio)
	gate_label.text = "Gate %d / %d" % [GameState.gate_hp, GameState.MAX_GATE_HP]

	repair_button.visible = not run_over \
		and GameState.gate_hp < GameState.MAX_GATE_HP \
		and GameState.wood >= GameState.REPAIR_WOOD_COST \
		and _player_in_repair_range()
	start_night_button.visible = not is_night and not run_over
	scavenge_button.visible = not is_night and not run_over and not scavenged_today


func _player_in_repair_range() -> bool:
	return player.global_position.distance_to(gate.global_position) <= REPAIR_RANGE


# --- Shooting -----------------------------------------------------------

func _on_aim_input(event: InputEvent) -> void:
	var pressed := false
	if event is InputEventScreenTouch and event.pressed:
		pressed = true
	elif event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		pressed = true
	if not pressed:
		return
	if not is_night or run_over:
		return

	match player.fire_at(get_global_mouse_position()):
		"fired":
			shot_sfx.play()
		"no_ammo":
			message_label.text = "Out of ammo!"
		"blocked":
			message_label.text = "Can't shoot while repairing!"


# --- Repair channel -----------------------------------------------------

func _on_repair_hold_started() -> void:
	if run_over:
		return
	if not _player_in_repair_range():
		message_label.text = "Get closer to the gate to repair!"
		return
	if GameState.gate_hp >= GameState.MAX_GATE_HP or GameState.wood < GameState.REPAIR_WOOD_COST:
		return
	_channel_duration = REPAIR_CHANNEL_STARVING if (is_night and starving) else REPAIR_CHANNEL_FED
	_channel_active = true
	_channel_left = _channel_duration
	player.blocked = true
	repair_progress.visible = true


func _on_repair_hold_released() -> void:
	_stop_channel()


func _stop_channel() -> void:
	_channel_active = false
	player.blocked = false
	repair_progress.visible = false


func _advance_channel(delta: float) -> void:
	if not _channel_active:
		return
	# Walking away interrupts the channel - repairing means standing still
	# at the gate while the horde closes in.
	if player.move_direction.length() > 0.1 or not _player_in_repair_range():
		_stop_channel()
		return
	if run_over or GameState.gate_hp >= GameState.MAX_GATE_HP or GameState.wood < GameState.REPAIR_WOOD_COST:
		_stop_channel()
		return

	_channel_left -= delta
	repair_progress.size.x = 240.0 * (1.0 - _channel_left / _channel_duration)
	if _channel_left <= 0.0:
		GameState.repair_gate()
		repair_sfx.play()
		message_label.text = "Patched the gate. (+%d HP)" % GameState.last_repair_amount
		if breached and GameState.gate_hp > 0:
			breached = false
			gate.reset_breach()
		# Keep channelling while held, needed, and affordable.
		_channel_left = _channel_duration


# --- Day actions --------------------------------------------------------

func _on_scavenge_pressed() -> void:
	if is_night or run_over or scavenged_today:
		return
	scavenged_today = true
	GameState.run_forest_expedition()
	message_label.text = "Scavenged the forest: +%d food, +%d wood, +%d ammo." % [
		GameState.last_loot_food, GameState.last_loot_wood, GameState.last_loot_ammo,
	]


func _on_start_night_pressed() -> void:
	if is_night or run_over:
		return
	is_night = true
	breached = false
	night_overlay.visible = true
	_stop_channel()

	# Food fuels the watchman: consumed at nightfall; an empty larder means
	# slower shooting and mending all night (spec §5).
	starving = GameState.food <= 0
	if not starving:
		GameState.food -= 1
	player.fire_cooldown = FIRE_COOLDOWN_STARVING if starving else FIRE_COOLDOWN_FED

	night_time = NIGHT_DURATION[GameState.day]
	_night_elapsed = 0.0
	_spawn_queue = SPAWN_SCHEDULE[GameState.day].duplicate()

	var count: int = ZOMBIES_PER_NIGHT[GameState.day]
	var note := " You are STARVING - slow to fire and mend." if starving else ""
	message_label.text = "Night %d - hold until dawn! %d incoming.%s" % [GameState.day, count, note]


func _spawn_zombie() -> void:
	var zombie := ZOMBIE_SCENE.instantiate()
	add_child(zombie)
	zombie.global_position = zombie_spawn.global_position + Vector2(randf_range(-SPAWN_X_SPREAD, SPAWN_X_SPREAD), 0.0)
	zombie.gate = gate
	zombie.speed = SPEED_BY_NIGHT[GameState.day]
	zombie.killed.connect(hit_sfx.play)
	zombie.clawed.connect(gate_hit_sfx.play)
	zombie.reached_player.connect(_on_player_overrun)


# --- Night resolution ---------------------------------------------------

func _dawn() -> void:
	is_night = false
	night_overlay.visible = false
	_stop_channel()
	for zombie in get_tree().get_nodes_in_group("zombies"):
		zombie.retreat()

	GameState.advance_after_realtime_night()
	if GameState.is_prototype_complete:
		_end_run(true)
		return

	scavenged_today = false
	message_label.text = "Dawn breaks - night survived! Day %d begins." % GameState.day


func _trigger_breach() -> void:
	breached = true
	gate.set_breached()
	for zombie in get_tree().get_nodes_in_group("zombies"):
		zombie.breach_target = player
	message_label.text = "THE GATE IS BREACHED - THEY'RE COMING FOR YOU!"


func _on_player_overrun() -> void:
	_end_run(false)


func _end_run(won: bool) -> void:
	run_over = true
	is_night = false
	night_overlay.visible = false
	_stop_channel()
	restart_button.visible = true
	for zombie in get_tree().get_nodes_in_group("zombies"):
		zombie.queue_free()
	for projectile in get_tree().get_nodes_in_group("projectiles"):
		projectile.queue_free()

	if won:
		message_label.text = "YOU SURVIVED UNTIL MORNING - all %d nights! Prototype complete." % GameState.TARGET_PROTOTYPE_DAYS
	else:
		GameState.is_game_over = true
		message_label.text = "Overrun on night %d. GAME OVER." % GameState.day


func _on_restart_pressed() -> void:
	if not run_over:
		return
	GameState.reset()
	get_tree().reload_current_scene()
