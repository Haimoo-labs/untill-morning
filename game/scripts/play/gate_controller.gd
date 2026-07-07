extends StaticBody2D

## The gate: blocks the player physically, tracks whether the player is
## in repair range, and swaps its texture between intact/damaged.

signal player_range_changed(in_range: bool)

const TEX_INTACT: Texture2D = preload("res://assets/sprites/props/gate_intact.png")

@onready var sprite: Sprite2D = $Sprite2D
@onready var repair_zone: Area2D = $RepairZone

var player_in_range: bool = false


func _ready() -> void:
	add_to_group("gate")
	set_collision_layer_value(1, true)
	repair_zone.body_entered.connect(_on_repair_zone_body_entered)
	repair_zone.body_exited.connect(_on_repair_zone_body_exited)
	sprite.texture = TEX_INTACT


func try_repair() -> bool:
	if GameState.wood < GameState.REPAIR_WOOD_COST or GameState.gate_hp >= GameState.MAX_GATE_HP:
		return false
	GameState.repair_gate()
	return true


func _on_repair_zone_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		player_range_changed.emit(true)


func _on_repair_zone_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		player_range_changed.emit(false)
