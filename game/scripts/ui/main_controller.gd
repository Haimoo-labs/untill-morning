extends Control

## Prototype v0.1 single-scene UI phase renderer (docs/prototype-v0.1/SCENE-FLOW.md).
## Rebuilds simple placeholder UI under PhaseContainer based on GameState.phase.

@onready var phase_container: VBoxContainer = $RootMargin/Root/PhaseContainer


func _ready() -> void:
	render()


func render() -> void:
	_clear_phase_container()

	match GameState.phase:
		GameState.Phase.MORNING:
			_render_morning()
		GameState.Phase.EXPEDITION_RESULT:
			_render_expedition_result()
		GameState.Phase.EVENING:
			_render_evening()
		GameState.Phase.NIGHT_RESULT:
			_render_night_result()
		GameState.Phase.MORNING_REPORT:
			_render_morning_report()
		GameState.Phase.PROTOTYPE_COMPLETE:
			_render_prototype_complete()
		GameState.Phase.GAME_OVER:
			_render_game_over()


func _clear_phase_container() -> void:
	for child in phase_container.get_children():
		child.queue_free()


func _add_label(text: String) -> void:
	var label := Label.new()
	label.text = text
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	phase_container.add_child(label)


func _add_button(text: String, callback: Callable) -> void:
	var button := Button.new()
	button.text = text
	button.pressed.connect(callback)
	phase_container.add_child(button)


func _render_status_block() -> void:
	_add_label("Day %d / %d" % [GameState.day, GameState.TARGET_PROTOTYPE_DAYS])
	_add_label("Food: %d   Wood: %d   Ammo: %d" % [GameState.food, GameState.wood, GameState.ammo])
	_add_label("Gate HP: %d / %d" % [GameState.gate_hp, GameState.MAX_GATE_HP])


func _render_morning() -> void:
	_add_label("Morning — Base Status")
	_render_status_block()
	_add_label("A new day begins. Choose an expedition.")
	_add_button("Go to Forest", _on_go_to_forest_pressed)


func _render_expedition_result() -> void:
	_add_label("Expedition: %s" % GameState.last_expedition_location)
	_add_label("Loot gained — Food: %d   Wood: %d   Ammo: %d" % [
		GameState.last_loot_food, GameState.last_loot_wood, GameState.last_loot_ammo,
	])
	_render_status_block()
	_add_button("Continue to Evening", _on_continue_to_evening_pressed)


func _render_evening() -> void:
	_add_label("Evening — Prepare for Night")
	_render_status_block()
	_add_label("Repair costs %d wood for up to %d HP." % [GameState.REPAIR_WOOD_COST, GameState.REPAIR_AMOUNT])
	_add_button("Repair Gate", _on_repair_gate_pressed)
	_add_button("Start Night", _on_start_night_pressed)


func _render_night_result() -> void:
	_add_label("Night Result")
	_add_label("Incoming damage: %d" % GameState.last_incoming_damage)
	_add_label("Ammo used: %d (blocked %d damage)" % [GameState.last_ammo_used, GameState.last_damage_blocked])
	_add_label("Gate damage: %d (HP %d -> %d)" % [
		GameState.last_gate_damage, GameState.last_gate_hp_before, GameState.last_gate_hp_after,
	])
	_render_status_block()
	_add_button("Continue", _on_continue_after_night_pressed)


func _render_morning_report() -> void:
	_add_label("Morning Report — Day %d survived" % GameState.day)
	if GameState.food == 0:
		_add_label("Warning: out of food.")
	_render_status_block()
	_add_button("Continue to Next Day", _on_start_next_day_pressed)


func _render_prototype_complete() -> void:
	_add_label("Prototype Complete")
	_add_label("You survived %d nights." % GameState.TARGET_PROTOTYPE_DAYS)
	_render_status_block()
	_add_button("Restart Prototype", _on_restart_pressed)


func _render_game_over() -> void:
	_add_label("Game Over")
	_add_label("The gate fell on Day %d." % GameState.day)
	_render_status_block()
	_add_button("Restart Prototype", _on_restart_pressed)


func _on_go_to_forest_pressed() -> void:
	GameState.run_forest_expedition()
	render()


func _on_continue_to_evening_pressed() -> void:
	GameState.continue_to_evening()
	render()


func _on_repair_gate_pressed() -> void:
	GameState.repair_gate()
	render()


func _on_start_night_pressed() -> void:
	GameState.start_night()
	render()


func _on_continue_after_night_pressed() -> void:
	GameState.continue_after_night()
	render()


func _on_start_next_day_pressed() -> void:
	GameState.start_next_day()
	render()


func _on_restart_pressed() -> void:
	GameState.reset()
	render()
