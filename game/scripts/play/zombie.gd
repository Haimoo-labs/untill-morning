extends CharacterBody2D

## Slow zombie (night-redesign spec §5): walks straight down to the gate,
## then persists and claws it on an interval until killed or dawn. On a
## breach it retargets the player; contact ends the run.

signal killed
signal clawed
signal reached_player

const MAX_HEALTH: int = 1
const CLAW_DAMAGE: int = 4
const CLAW_INTERVAL: float = 2.0
const GATE_STOP_OFFSET: float = 35.0
const PLAYER_CONTACT_RADIUS: float = 40.0
const BREACH_SPEED_MULTIPLIER: float = 1.4

var speed: float = 45.0
var gate: Node2D = null
var breach_target: Node2D = null
var health: int = MAX_HEALTH

var _dead: bool = false
var _retreating: bool = false
var _at_gate: bool = false
var _claw_timer: float = 0.0


func _ready() -> void:
	add_to_group("zombies")
	set_collision_layer_value(1, false)
	set_collision_layer_value(3, true)
	set_collision_mask_value(1, false)


func _physics_process(delta: float) -> void:
	if _dead or _retreating:
		return

	if breach_target != null:
		var to_player: Vector2 = breach_target.global_position - global_position
		if to_player.length() <= PLAYER_CONTACT_RADIUS:
			_dead = true
			reached_player.emit()
			return
		velocity = to_player.normalized() * speed * BREACH_SPEED_MULTIPLIER
		move_and_slide()
		return

	if gate == null:
		return

	var stop_y: float = gate.global_position.y - GATE_STOP_OFFSET
	if global_position.y < stop_y:
		_at_gate = false
		velocity = Vector2(0.0, speed)
		move_and_slide()
	else:
		if not _at_gate:
			_at_gate = true
			_claw_timer = 0.0  # first claw lands on arrival
		_claw_timer -= delta
		if _claw_timer <= 0.0:
			_claw_timer = CLAW_INTERVAL
			GameState.gate_hp = max(0, GameState.gate_hp - CLAW_DAMAGE)
			clawed.emit()


func take_hit(damage: int = 1) -> void:
	if _dead or _retreating:
		return
	health -= damage
	_flash_hit()
	if health <= 0:
		_dead = true
		killed.emit()
		queue_free()


## Dawn: survivors stop clawing, fade out, and free themselves.
func retreat() -> void:
	if _dead or _retreating:
		return
	_retreating = true
	var tween := create_tween()
	tween.tween_property($Sprite2D, "modulate:a", 0.0, 0.8)
	tween.tween_callback(queue_free)


func _flash_hit() -> void:
	var sprite: Sprite2D = $Sprite2D
	sprite.modulate = Color(2.0, 0.6, 0.5)
	var tween := create_tween()
	tween.tween_property(sprite, "modulate", Color.WHITE, 0.25)
