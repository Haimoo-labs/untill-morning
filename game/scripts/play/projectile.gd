extends Area2D

## Straight-line projectile. Damages the first zombie it touches, then frees itself.

const SPEED: float = 420.0
const LIFETIME: float = 1.5
const DAMAGE: int = 1

var direction: Vector2 = Vector2.RIGHT
var _age: float = 0.0


func _ready() -> void:
	set_collision_layer_value(1, false)
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
