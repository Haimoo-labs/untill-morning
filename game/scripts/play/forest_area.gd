extends Node2D

## Placeholder forest (GDD §11): a cold, grey-olive walkable area east of
## camp. Ground and tree canopies are drawn procedurally (placeholder art
## rule); tree trunks and the area boundary get StaticBody2D colliders built
## in _ready. Local coordinates cover a 720x1600 rect; the node is placed at
## the forest origin in the world scene.

const AREA_SIZE: Vector2 = Vector2(720, 1600)
# Visual radius sits just outside the collider so what blocks is what shows.
const TREE_RADIUS: float = 40.0
const TRUNK_COLLIDER_RADIUS: float = 38.0
const GROUND_COLOR: Color = Color(0.15, 0.18, 0.14)
const CANOPY_COLOR: Color = Color(0.1, 0.13, 0.1)
const CANOPY_RIM_COLOR: Color = Color(0.07, 0.09, 0.07)

# Hand-placed so paths stay open and the bottom entry area is clear.
const TREES: Array = [
	Vector2(120, 220), Vector2(340, 150), Vector2(590, 250),
	Vector2(210, 470), Vector2(520, 520), Vector2(100, 760),
	Vector2(410, 740), Vector2(630, 920), Vector2(230, 1030),
	Vector2(550, 1180), Vector2(140, 1300),
]

# The forest owns its layout: pickup spots live beside the trees they must
# avoid. Local coordinates; PlayWorld offsets by this node's position.
const PICKUP_SPOTS: Array = [
	Vector2(250, 310), Vector2(470, 390), Vector2(130, 590),
	Vector2(600, 650), Vector2(330, 910), Vector2(170, 1150),
	Vector2(500, 1040), Vector2(360, 1310), Vector2(640, 1260),
	Vector2(80, 950),
]
const ENTRY_POINT: Vector2 = Vector2(360, 1460)


func _ready() -> void:
	var body := StaticBody2D.new()
	body.name = "ForestColliders"
	body.set_collision_layer_value(1, true)
	add_child(body)

	for tree_position in TREES:
		_add_circle_collider(body, tree_position, TRUNK_COLLIDER_RADIUS)

	# Boundary walls: left, right, top, bottom.
	_add_wall(body, Vector2(-10, AREA_SIZE.y / 2), Vector2(20, AREA_SIZE.y + 40))
	_add_wall(body, Vector2(AREA_SIZE.x + 10, AREA_SIZE.y / 2), Vector2(20, AREA_SIZE.y + 40))
	_add_wall(body, Vector2(AREA_SIZE.x / 2, -10), Vector2(AREA_SIZE.x + 40, 20))
	_add_wall(body, Vector2(AREA_SIZE.x / 2, AREA_SIZE.y + 10), Vector2(AREA_SIZE.x + 40, 20))


func _add_circle_collider(body: StaticBody2D, at: Vector2, radius: float) -> void:
	var shape := CircleShape2D.new()
	shape.radius = radius
	var collider := CollisionShape2D.new()
	collider.shape = shape
	collider.position = at
	body.add_child(collider)


func _add_wall(body: StaticBody2D, at: Vector2, size: Vector2) -> void:
	var shape := RectangleShape2D.new()
	shape.size = size
	var collider := CollisionShape2D.new()
	collider.shape = shape
	collider.position = at
	body.add_child(collider)


func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, AREA_SIZE), GROUND_COLOR)
	for tree_position in TREES:
		draw_circle(tree_position, TREE_RADIUS + 6.0, CANOPY_RIM_COLOR)
		draw_circle(tree_position, TREE_RADIUS, CANOPY_COLOR)
