extends StaticBody2D

## The palisade gate: the only obstacle between the horde and the watchman.
## Damage reads through color (darkens/reddens as HP drops); a breach
## disables the collider so zombies pour through.

const TEX_INTACT: Texture2D = preload("res://assets/sprites/props/gate_intact.png")

@onready var sprite: Sprite2D = $Sprite2D
@onready var collider: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	add_to_group("gate")
	set_collision_layer_value(1, true)
	sprite.texture = TEX_INTACT


func _process(_delta: float) -> void:
	var ratio: float = float(GameState.gate_hp) / float(GameState.MAX_GATE_HP)
	sprite.modulate = Color(1.0, 0.35 + 0.65 * ratio, 0.35 + 0.65 * ratio)


func set_breached() -> void:
	collider.set_deferred("disabled", true)


func reset_breach() -> void:
	collider.set_deferred("disabled", false)
