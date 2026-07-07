extends CharacterBody2D

## The watchman (night-redesign spec §1-2): anchored at the gate for the whole
## run - no movement. Fires straight aimed shots at tapped world points,
## throttled by a cooldown that doubles when starving. Repair channelling
## blocks firing via `blocked`.

const PROJECTILE_SCENE: PackedScene = preload("res://scenes/play/projectile.tscn")

const IDLE_BOB_SPEED: float = 2.2
const IDLE_BOB_AMOUNT: float = 1.5

@onready var sprite: Sprite2D = $Sprite2D
@onready var muzzle: Marker2D = $Muzzle

var fire_cooldown: float = 0.35  # set per night by PlayWorld (fed/starving)
var blocked: bool = false        # true while the repair channel is held

var _cooldown_left: float = 0.0
var _anim_time: float = 0.0
var _sprite_base_position: Vector2


func _ready() -> void:
	set_collision_layer_value(1, false)
	set_collision_layer_value(2, true)
	set_collision_mask_value(1, true)
	_sprite_base_position = sprite.position


func _process(delta: float) -> void:
	_cooldown_left = maxf(0.0, _cooldown_left - delta)
	_anim_time += delta * IDLE_BOB_SPEED
	sprite.position = _sprite_base_position + Vector2(0.0, sin(_anim_time) * IDLE_BOB_AMOUNT)


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
