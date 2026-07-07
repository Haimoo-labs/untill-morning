extends Control

## Touch/mouse-drag virtual joystick. Emits a normalized -1..1 Vector2.

signal direction_changed(direction: Vector2)

@export var radius: float = 60.0
@export var knob_radius: float = 28.0

var _center: Vector2
var _knob_offset: Vector2 = Vector2.ZERO
var _active: bool = false
var _touch_index: int = -1


func _ready() -> void:
	_center = size / 2.0
	mouse_filter = Control.MOUSE_FILTER_STOP


func _gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed and _touch_index == -1:
			_touch_index = event.index
			_start(event.position)
		elif not event.pressed and event.index == _touch_index:
			_touch_index = -1
			_stop()
	elif event is InputEventScreenDrag:
		if event.index == _touch_index:
			_update(event.position)
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			_start(event.position)
		else:
			_stop()
	elif event is InputEventMouseMotion:
		if _active:
			_update(event.position)


func _start(pos: Vector2) -> void:
	_active = true
	_update(pos)


func _update(pos: Vector2) -> void:
	var offset := pos - _center
	if offset.length() > radius:
		offset = offset.normalized() * radius
	_knob_offset = offset
	queue_redraw()
	direction_changed.emit(_knob_offset / radius)


func _stop() -> void:
	_active = false
	_touch_index = -1
	_knob_offset = Vector2.ZERO
	queue_redraw()
	direction_changed.emit(Vector2.ZERO)


func _draw() -> void:
	draw_circle(_center, radius, Color(1, 1, 1, 0.15))
	draw_circle(_center, radius, Color(1, 1, 1, 0.35), false, 2.0)
	draw_circle(_center + _knob_offset, knob_radius, Color(1, 1, 1, 0.45))
