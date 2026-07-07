extends Area2D

## A forest resource pickup: walking over it gathers one unit. Placeholder
## visual is a colored disc with a dark outline (drawn, no asset needed).

signal collected(kind: String)

const KIND_COLORS: Dictionary = {
	"food": Color(0.62, 0.68, 0.42),
	"wood": Color(0.52, 0.38, 0.2),
	"ammo": Color(0.66, 0.68, 0.7),
}

var kind: String = "wood"


func _ready() -> void:
	add_to_group("pickups")
	# Detect only the player (layer 2). Clear the default bit 1 on both layer
	# and mask explicitly - Area2D defaults have bitten this project before.
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	set_collision_mask_value(2, true)
	body_entered.connect(_on_body_entered)


func _draw() -> void:
	draw_circle(Vector2.ZERO, 17.0, Color(0.06, 0.07, 0.06, 0.9))
	draw_circle(Vector2.ZERO, 13.0, KIND_COLORS.get(kind, Color.WHITE))


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	collected.emit(kind)
	queue_free()
