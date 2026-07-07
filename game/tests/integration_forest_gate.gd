extends SceneTree

## Headless integration test: walkable forest expedition + numberless gate.
## Run: godot --headless --path game -s res://tests/integration_forest_gate.gd

var world: Node2D
var game_state: Node
var failures: int = 0


func _init() -> void:
	call_deferred("_run")


func _check(label: String, ok: bool) -> void:
	if ok:
		print("PASS: %s" % label)
	else:
		failures += 1
		printerr("FAIL: %s" % label)


func _run() -> void:
	game_state = root.get_node("/root/GameState")
	game_state.reset()

	var scene: PackedScene = load("res://scenes/play/play_world.tscn")
	world = scene.instantiate()
	root.add_child(world)
	await process_frame
	await process_frame

	await _test_gate_states()
	await _test_forest_expedition()
	await _test_night_and_dawn()

	print("---")
	if failures == 0:
		print("ALL TESTS PASSED")
		quit(0)
	else:
		printerr("%d FAILURES" % failures)
		quit(1)


func _test_gate_states() -> void:
	var gate_label: Label = world.get_node("CanvasLayer/HUD/GateLabel")
	var gate: StaticBody2D = world.get_node("Gate")

	_check("gate starts Holding", gate_label.text == "Gate: Holding")
	_check("no damage cracks when intact", not gate._damage_cracks[0].visible)

	game_state.gate_hp = 50
	await process_frame
	_check("gate 50hp reads Damaged", gate_label.text == "Gate: Damaged")
	_check("damage cracks visible", gate._damage_cracks[0].visible)
	_check("failing cracks hidden at Damaged", not gate._failing_cracks[0].visible)

	game_state.gate_hp = 20
	await process_frame
	_check("gate 20hp reads FAILING", gate_label.text == "Gate: FAILING")
	_check("failing cracks visible", gate._failing_cracks[0].visible)
	# The sag lives on the sprite - rotating the body would swing the live
	# collider into a player standing against the gate.
	_check("gate sprite sags when failing", gate.sprite.rotation > 0.01)
	_check("gate collider does not rotate", gate.rotation == 0.0)

	game_state.gate_hp = 0
	await process_frame
	_check("gate 0hp reads BREACHED", gate_label.text == "Gate: BREACHED")
	_check("HUD gate text has no digits", not _has_digit(gate_label.text))

	game_state.gate_hp = game_state.MAX_GATE_HP
	await process_frame
	_check("gate back to Holding after reset", gate_label.text == "Gate: Holding")


func _test_forest_expedition() -> void:
	var player: CharacterBody2D = world.get_node("Player")
	var camera: Camera2D = player.get_node("Camera2D")
	var forest_button: Button = world.get_node("CanvasLayer/HUD/ForestButton")
	var return_button: Button = world.get_node("CanvasLayer/HUD/ReturnButton")
	var start_night_button: Button = world.get_node("CanvasLayer/HUD/StartNightButton")

	var food_before: int = game_state.food
	var wood_before: int = game_state.wood
	var ammo_before: int = game_state.ammo

	_check("forest button visible at day start", forest_button.visible)
	forest_button.pressed.emit()
	await process_frame

	_check("entered forest", world.in_forest)
	_check("player teleported into forest", player.global_position.x > 1200.0)
	_check("camera limited to forest", camera.limit_left == 1200 and camera.limit_right == 1920)
	_check("start night hidden in forest", not start_night_button.visible)
	_check("return button visible in forest", return_button.visible)
	_check("forest button hidden in forest", not forest_button.visible)

	var pickups: Array = root.get_tree().get_nodes_in_group("pickups")
	var expected_total: int = pickups.size()
	_check("pickup count within loot table range", expected_total >= 4 and expected_total <= 5)
	_check("loot bookkeeping starts at zero (gained, not rolled)",
		game_state.last_loot_food == 0 and game_state.last_loot_wood == 0 and game_state.last_loot_ammo == 0)

	# Returning without gathering must not forfeit the day's loot.
	return_button.pressed.emit()
	await process_frame
	_check("early return keeps forest open for re-entry", forest_button.visible)
	_check("early return preserves pickups",
		root.get_tree().get_nodes_in_group("pickups").size() == expected_total)

	forest_button.pressed.emit()
	await process_frame
	_check("re-entry does not re-roll pickups",
		root.get_tree().get_nodes_in_group("pickups").size() == expected_total)

	# Walk over every pickup (teleport + physics frames trigger Area2D).
	for pickup in root.get_tree().get_nodes_in_group("pickups"):
		player.global_position = pickup.global_position
		await physics_frame
		await physics_frame
	await process_frame

	_check("all pickups collected", root.get_tree().get_nodes_in_group("pickups").is_empty())
	_check("food gained matches bookkeeping", game_state.food - food_before == game_state.last_loot_food)
	_check("wood gained matches bookkeeping", game_state.wood - wood_before == game_state.last_loot_wood)
	_check("ammo gained matches bookkeeping", game_state.ammo - ammo_before == game_state.last_loot_ammo)
	_check("total gained matches pickup count",
		game_state.last_loot_food + game_state.last_loot_wood + game_state.last_loot_ammo == expected_total)

	return_button.pressed.emit()
	await process_frame
	_check("back at camp", not world.in_forest)
	_check("player teleported to camp", player.global_position.x < 720.0)
	_check("camera limited to camp", camera.limit_left == 0 and camera.limit_right == 720)
	_check("forest button hidden once cleared and gathered", not forest_button.visible)
	_check("start night visible again", start_night_button.visible)


func _test_night_and_dawn() -> void:
	var start_night_button: Button = world.get_node("CanvasLayer/HUD/StartNightButton")
	var forest_button: Button = world.get_node("CanvasLayer/HUD/ForestButton")

	start_night_button.pressed.emit()
	await process_frame
	_check("night started", world.is_night)
	_check("forest button hidden at night", not forest_button.visible)

	await create_timer(0.3).timeout
	_check("first zombie spawned", not root.get_tree().get_nodes_in_group("zombies").is_empty())

	# Fast-forward to dawn.
	world.night_time = 0.05
	await create_timer(0.3).timeout
	_check("dawn ended the night", not world.is_night)
	_check("day advanced to 2", game_state.day == 2)
	_check("forest available again next day", forest_button.visible)


func _has_digit(text: String) -> bool:
	for i in range(10):
		if str(i) in text:
			return true
	return false
