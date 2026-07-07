extends StaticBody2D

## The palisade gate: the only obstacle between the horde and the watchman.
## Condition reads without numbers in three visual states (GDD §9): intact,
## damaged (cracks appear), near-broken (splintered and sagging). A breach
## disables the collider so zombies pour through.

const TEX_INTACT: Texture2D = preload("res://assets/sprites/props/gate_intact.png")

const CRACK_COLOR: Color = Color(0.08, 0.08, 0.08, 0.9)
# Fixed jagged polylines in gate-local coordinates (collider is 400x40).
const CRACKS_DAMAGED: Array = [
	[Vector2(-120, -18), Vector2(-100, -2), Vector2(-112, 14)],
	[Vector2(60, -16), Vector2(48, 0), Vector2(66, 16)],
]
const CRACKS_FAILING: Array = [
	[Vector2(-30, -18), Vector2(-20, -4), Vector2(-36, 10), Vector2(-24, 18)],
	[Vector2(140, -14), Vector2(128, 2), Vector2(144, 12)],
	[Vector2(-180, -10), Vector2(-166, 4), Vector2(-176, 16)],
]

const MODULATE_BY_STATE: Dictionary = {
	"intact": Color(1.0, 1.0, 1.0),
	"damaged": Color(0.88, 0.76, 0.72),
	"near_broken": Color(0.76, 0.52, 0.48),
	"breached": Color(0.55, 0.35, 0.32),
}

@onready var sprite: Sprite2D = $Sprite2D
@onready var collider: CollisionShape2D = $CollisionShape2D

var _damage_cracks: Array[Line2D] = []
var _failing_cracks: Array[Line2D] = []
var _current_state: String = ""


func _ready() -> void:
	add_to_group("gate")
	set_collision_layer_value(1, true)
	sprite.texture = TEX_INTACT
	_damage_cracks = _build_cracks(CRACKS_DAMAGED, 4.0)
	_failing_cracks = _build_cracks(CRACKS_FAILING, 6.0)


func _build_cracks(polylines: Array, width: float) -> Array[Line2D]:
	var lines: Array[Line2D] = []
	for points in polylines:
		var line := Line2D.new()
		for point in points:
			line.add_point(point)
		line.width = width
		line.default_color = CRACK_COLOR
		line.visible = false
		add_child(line)
		lines.append(line)
	return lines


# State changes are discrete (claws, repairs), so visuals update only when
# the state actually flips - no per-frame transform or theme churn.
func _process(_delta: float) -> void:
	var state: String = GameState.gate_state()
	if state == _current_state:
		return
	_current_state = state
	sprite.modulate = MODULATE_BY_STATE[state]
	var show_damage: bool = state != "intact"
	var show_failing: bool = state == "near_broken" or state == "breached"
	for line in _damage_cracks:
		line.visible = show_damage
	for line in _failing_cracks:
		line.visible = show_failing
	# Near-broken sags visibly - the timber leans. Rotate the sprite only;
	# rotating the body would swing the live collider into the player.
	sprite.rotation = 0.02 if show_failing else 0.0


## A visible pulse so every completed repair reads even when it does not
## cross a state threshold (the bands are ~33 HP wide vs +20 HP per patch).
func flash_repair() -> void:
	sprite.modulate = Color(1.5, 1.7, 1.3)
	var tween := create_tween()
	tween.tween_property(sprite, "modulate", MODULATE_BY_STATE[GameState.gate_state()], 0.4)


func set_breached() -> void:
	collider.set_deferred("disabled", true)


func reset_breach() -> void:
	collider.set_deferred("disabled", false)
