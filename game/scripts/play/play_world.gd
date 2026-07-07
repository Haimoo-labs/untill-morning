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

# Walkable forest expedition (GDD §6/§11): a separate area east of camp.
# Geometry (origin, extents, spots, entry) is owned by the ForestArea node -
# nothing here duplicates its placement.
const PICKUP_SCENE: PackedScene = preload("res://scenes/play/forest_pickup.tscn")
const CAMP_RETURN_POSITION: Vector2 = Vector2(360, 900)

@onready var player: CharacterBody2D = $Player
@onready var camera: Camera2D = $Player/Camera2D
@onready var gate: StaticBody2D = $Gate
@onready var forest_area: Node2D = $ForestArea
@onready var zombie_spawn: Marker2D = $ZombieSpawn
@onready var night_overlay: ColorRect = $CanvasLayer/NightOverlay
@onready var joystick: Control = $CanvasLayer/HUD/VirtualJoystick
@onready var aim_catcher: Control = $CanvasLayer/HUD/AimCatcher
@onready var repair_button: Button = $CanvasLayer/HUD/RepairButton
@onready var repair_progress: ColorRect = $CanvasLayer/HUD/RepairProgress
@onready var forest_button: Button = $CanvasLayer/HUD/ForestButton
@onready var return_button: Button = $CanvasLayer/HUD/ReturnButton
@onready var start_night_button: Button = $CanvasLayer/HUD/StartNightButton
@onready var restart_button: Button = $CanvasLayer/HUD/RestartButton
@onready var message_label: Label = $CanvasLayer/HUD/MessageLabel
@onready var day_label: Label = $CanvasLayer/HUD/DayLabel
@onready var ammo_label: Label = $CanvasLayer/HUD/AmmoLabel
@onready var food_label: Label = $CanvasLayer/HUD/FoodLabel
@onready var wood_label: Label = $CanvasLayer/HUD/WoodLabel
@onready var gate_label: Label = $CanvasLayer/HUD/GateLabel
@onready var shot_sfx: AudioStreamPlayer = $ShotSfx
@onready var hit_sfx: AudioStreamPlayer = $HitSfx
@onready var repair_sfx: AudioStreamPlayer = $RepairSfx
@onready var gate_hit_sfx: AudioStreamPlayer = $GateHitSfx

# Numberless gate readout (GDD §9/§18): state text + color, no HP figures.
const GATE_STATE_TEXT: Dictionary = {
	"intact": "Gate: Holding",
	"damaged": "Gate: Damaged",
	"near_broken": "Gate: FAILING",
	"breached": "Gate: BREACHED",
}
const GATE_STATE_COLOR: Dictionary = {
	"intact": Color(0.72, 0.78, 0.68),
	"damaged": Color(0.85, 0.64, 0.38),
	"near_broken": Color(0.9, 0.38, 0.3),
	"breached": Color(0.95, 0.25, 0.2),
}

var is_night: bool = false
var run_over: bool = false
var breached: bool = false
var scavenged_today: bool = false
var starving: bool = false
var in_forest: bool = false

var _pickups_left: int = 0
var _last_gate_state: String = ""
# Camp camera limits as authored on the Camera2D in the scene; captured in
# _ready so the scene stays the single source of truth.
var _camp_limit_left: int = 0
var _camp_limit_right: int = 720

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
	forest_button.pressed.connect(_on_forest_pressed)
	return_button.pressed.connect(_on_return_pressed)
	start_night_button.pressed.connect(_on_start_night_pressed)
	restart_button.pressed.connect(_on_restart_pressed)

	restart_button.visible = false
	night_overlay.visible = false
	repair_progress.visible = false
	_camp_limit_left = camera.limit_left
	_camp_limit_right = camera.limit_right
	message_label.text = "Day 1. Gather in the forest, repair, and hold the gate for 3 nights. Tap zombies to shoot."
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
	if is_night:
		day_label.text = "Night %d - dawn in %ds" % [GameState.day, ceili(maxf(night_time, 0.0))]
	else:
		day_label.text = "Day %d / %d" % [GameState.day, GameState.TARGET_PROTOTYPE_DAYS]
	ammo_label.text = "Ammo: %d" % GameState.ammo
	wood_label.text = "Wood: %d" % GameState.wood
	if is_night:
		food_label.text = "STARVING" if starving else "Fed"
	else:
		food_label.text = "Food: %d" % GameState.food

	# Theme overrides re-shape the label; only touch it on a state flip.
	var gate_state: String = GameState.gate_state()
	if gate_state != _last_gate_state:
		_last_gate_state = gate_state
		gate_label.text = GATE_STATE_TEXT[gate_state]
		gate_label.add_theme_color_override("font_color", GATE_STATE_COLOR[gate_state])

	repair_button.visible = not run_over and not in_forest \
		and GameState.gate_hp < GameState.MAX_GATE_HP \
		and GameState.wood >= GameState.REPAIR_WOOD_COST \
		and _player_in_repair_range()
	start_night_button.visible = not is_night and not run_over and not in_forest
	# The forest stays open all day: re-entry is allowed while gathered-day
	# pickups remain, so a stray Return tap never forfeits the day's loot.
	forest_button.visible = not is_night and not run_over and not in_forest \
		and (not scavenged_today or _pickups_left > 0)
	return_button.visible = in_forest and not run_over


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
		gate.flash_repair()
		repair_sfx.play()
		message_label.text = "Patched the gate."
		if breached and GameState.gate_hp > 0:
			breached = false
			gate.reset_breach()
		# Keep channelling while held, needed, and affordable.
		_channel_left = _channel_duration


# --- Day actions --------------------------------------------------------

func _on_forest_pressed() -> void:
	if is_night or run_over or in_forest:
		return
	if scavenged_today and _pickups_left <= 0:
		return
	in_forest = true
	_stop_channel()
	if not scavenged_today:
		scavenged_today = true
		_spawn_forest_pickups()
	player.global_position = forest_area.position + forest_area.ENTRY_POINT
	_set_camera_limits(int(forest_area.position.x), int(forest_area.position.x + forest_area.AREA_SIZE.x))
	message_label.text = "The forest. Walk over supplies to gather them, then head back to camp."


func _spawn_forest_pickups() -> void:
	var loot: Dictionary = GameState.roll_forest_loot()
	var kinds: Array = []
	for kind in loot:
		for _i in range(loot[kind]):
			kinds.append(kind)

	var spots: Array = forest_area.PICKUP_SPOTS.duplicate()
	spots.shuffle()
	_pickups_left = kinds.size()
	for i in range(kinds.size()):
		var pickup := PICKUP_SCENE.instantiate()
		pickup.kind = kinds[i]
		add_child(pickup)
		# Render under the player: ground clutter, not an overlay.
		move_child(pickup, player.get_index())
		pickup.global_position = forest_area.position + spots[i]
		pickup.collected.connect(_on_pickup_collected)


func _on_pickup_collected(kind: String) -> void:
	GameState.grant_loot(kind)
	_pickups_left -= 1
	if _pickups_left <= 0:
		message_label.text = "Picked up %s. The forest is cleared - head back to camp." % kind
	else:
		message_label.text = "Picked up %s." % kind


func _on_return_pressed() -> void:
	if not in_forest or run_over:
		return
	in_forest = false
	player.global_position = CAMP_RETURN_POSITION
	_set_camera_limits(_camp_limit_left, _camp_limit_right)
	if _pickups_left > 0:
		message_label.text = "Back at camp. %d supplies still lie out in the forest." % _pickups_left
	else:
		message_label.text = "Back at camp. Repair the gate or start the night."


func _clear_pickups() -> void:
	_pickups_left = 0
	for pickup in get_tree().get_nodes_in_group("pickups"):
		pickup.queue_free()


func _set_camera_limits(left: int, right: int) -> void:
	camera.limit_left = left
	camera.limit_right = right
	camera.reset_smoothing()


func _on_start_night_pressed() -> void:
	if is_night or run_over or in_forest:
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
	# Yesterday's ungathered supplies are gone - a new day rolls fresh.
	_clear_pickups()
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
	_clear_pickups()

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
