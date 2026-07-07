extends CharacterBody2D

## Real-time top-down player: joystick movement + ranged fire toward the nearest zombie.

const SPEED: float = 140.0
const PROJECTILE_SCENE: PackedScene = preload("res://scenes/play/projectile.tscn")

# Lightweight procedural "alive" motion (no sprite frames): a slow breathing
# bob while idle, a faster bounce/tilt while walking.
const IDLE_BOB_SPEED: float = 2.2
const IDLE_BOB_AMOUNT: float = 1.5
const WALK_BOB_SPEED: float = 9.0
const WALK_BOB_AMOUNT: float = 4.0
const WALK_TILT_AMOUNT: float = 0.05

@onready var sprite: Sprite2D = $Sprite2D
@onready var muzzle: Marker2D = $Muzzle

var move_direction: Vector2 = Vector2.ZERO
var facing: Vector2 = Vector2.DOWN
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
		facing = move_direction.normalized()
		sprite.flip_h = facing.x < 0


func _process(delta: float) -> void:
	var is_moving := move_direction.length() > 0.1
	var bob_speed: float = WALK_BOB_SPEED if is_moving else IDLE_BOB_SPEED
	var bob_amount: float = WALK_BOB_AMOUNT if is_moving else IDLE_BOB_AMOUNT

	_anim_time += delta * bob_speed
	sprite.position = _sprite_base_position + Vector2(0.0, sin(_anim_time) * -absf(bob_amount) + bob_amount)

	if is_moving:
		sprite.rotation = sin(_anim_time) * WALK_TILT_AMOUNT
	else:
		sprite.rotation = lerp(sprite.rotation, 0.0, delta * 6.0)


func set_move_direction(dir: Vector2) -> void:
	move_direction = dir


func fire() -> void:
	if GameState.ammo <= 0:
		return

	var target := _find_nearest_zombie()
	var direction := facing
	if target:
		direction = (target.global_position - global_position).normalized()

	GameState.ammo -= 1

	var projectile := PROJECTILE_SCENE.instantiate()
	get_parent().add_child(projectile)
	projectile.global_position = muzzle.global_position
	projectile.direction = direction


func _find_nearest_zombie() -> Node2D:
	var zombies := get_tree().get_nodes_in_group("zombies")
	var nearest: Node2D = null
	var nearest_dist := INF
	for zombie in zombies:
		var dist: float = global_position.distance_squared_to(zombie.global_position)
		if dist < nearest_dist:
			nearest_dist = dist
			nearest = zombie
	return nearest
