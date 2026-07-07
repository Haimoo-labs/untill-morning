extends Area2D

## Straight aimed shot (night-redesign spec §2): direction is fixed at spawn,
## no homing. A tap on a zombie connects; a tap into a gap misses and the
## ammo is gone - that miss cost is the skill floor.

const SPEED: float = 500.0
const LIFETIME: float = 2.5
const DAMAGE: int = 1

var direction: Vector2 = Vector2.UP
var _age: float = 0.0


func _ready() -> void:
	add_to_group("projectiles")
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	set_collision_mask_value(3, true)
	body_entered.connect(_on_body_entered)
	rotation = direction.angle()


func _draw() -> void:
	draw_circle(Vector2.ZERO, 4.0, Color("#f2c166"))


func _physics_process(delta: float) -> void:
	position += direction * SPEED * delta
	_age += delta
	if _age >= LIFETIME:
		queue_free()


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("zombies") and body.has_method("take_hit"):
		body.take_hit(DAMAGE)
		queue_free()
