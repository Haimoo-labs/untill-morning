extends CharacterBody2D

## The watchman: moves freely in the world (virtual joystick) and fires
## straight aimed shots at tapped world points. The fire cooldown doubles
## when starving; the repair channel blocks firing via `blocked`.

const PROJECTILE_SCENE: PackedScene = preload("res://scenes/play/projectile.tscn")

const SPEED: float = 140.0
const IDLE_BOB_SPEED: float = 2.2
const IDLE_BOB_AMOUNT: float = 1.5
const WALK_BOB_SPEED: float = 9.0
const WALK_BOB_AMOUNT: float = 4.0
const WALK_TILT_AMOUNT: float = 0.05

@onready var sprite: Sprite2D = $Sprite2D
@onready var muzzle: Marker2D = $Muzzle

var fire_cooldown: float = 0.35  # set per night by PlayWorld (fed/starving)
var blocked: bool = false        # true while the repair channel is held
var move_direction: Vector2 = Vector2.ZERO

var _cooldown_left: float = 0.0
var _anim_time: float = 0.0
var _sprite_base_position: Vector2


func _ready() -> void:
	set_collision_layer_value(1, false)
	set_collision_layer_value(2, true)
	set_collision_mask_value(1, true)
	_sprite_base_position = sprite.position


func _physics_process(_delta: float) -> void:
	velocity = move_direction * SPEED
	move_and_slide()
	if move_direction.length() > 0.1:
		sprite.flip_h = move_direction.x < 0


func _process(delta: float) -> void:
	_cooldown_left = maxf(0.0, _cooldown_left - delta)

	var is_moving := move_direction.length() > 0.1
	var bob_speed: float = WALK_BOB_SPEED if is_moving else IDLE_BOB_SPEED
	var bob_amount: float = WALK_BOB_AMOUNT if is_moving else IDLE_BOB_AMOUNT
	_anim_time += delta * bob_speed
	sprite.position = _sprite_base_position + Vector2(0.0, sin(_anim_time) * bob_amount * 0.5)
	if is_moving:
		sprite.rotation = sin(_anim_time) * WALK_TILT_AMOUNT
	else:
		sprite.rotation = lerp(sprite.rotation, 0.0, delta * 6.0)


func set_move_direction(dir: Vector2) -> void:
	move_direction = dir


## Returns "fired", "no_ammo", "cooldown" or "blocked" so the HUD can react.
func fire_at(world_point: Vector2) -> String:
	if blocked:
		return "blocked"
	if _cooldown_left > 0.0:
		return "cooldown"
	if GameState.ammo <= 0:
		return "no_ammo"

	GameState.ammo -= 1
	_cooldown_left = fire_cooldown
	sprite.flip_h = world_point.x < global_position.x

	var projectile := PROJECTILE_SCENE.instantiate()
	get_parent().add_child(projectile)
	projectile.global_position = muzzle.global_position
	projectile.direction = (world_point - muzzle.global_position).normalized()
	return "fired"
