extends CharacterBody2D

## Slow zombie: walks straight toward the gate. Dies after a few hits,
## or deals one fixed hit to GameState.gate_hp if it reaches the gate.

signal resolved(outcome: String)
signal hit

const SPEED: float = 40.0
const MAX_HEALTH: int = 3
const GATE_DAMAGE: int = 15
const REACH_DISTANCE: float = 40.0

var target: Node2D = null
var health: int = MAX_HEALTH
var _resolved: bool = false


func _ready() -> void:
	add_to_group("zombies")
	set_collision_layer_value(1, false)
	set_collision_layer_value(3, true)
	set_collision_mask_value(1, false)


func _physics_process(_delta: float) -> void:
	if _resolved or target == null:
		return

	var to_target: Vector2 = target.global_position - global_position
	if to_target.length() <= REACH_DISTANCE:
		_reach_gate()
		return

	velocity = to_target.normalized() * SPEED
	move_and_slide()


func take_hit(damage: int = 1) -> void:
	if _resolved:
		return
	health -= damage
	_flash_hit()
	hit.emit()
	if health <= 0:
		_resolved = true
		resolved.emit("killed")
		queue_free()


func _flash_hit() -> void:
	var sprite: Sprite2D = $Sprite2D
	sprite.modulate = Color(2.0, 0.6, 0.5)
	var tween := create_tween()
	tween.tween_property(sprite, "modulate", Color.WHITE, 0.25)


func _reach_gate() -> void:
	_resolved = true
	GameState.gate_hp = max(0, GameState.gate_hp - GATE_DAMAGE)
	resolved.emit("reached_gate")
	queue_free()
