class_name TrailComponent extends Line2D

@export var is_emitting: bool = false
@export var resolution: float = 5.0
@export var lifetime: float = 0.5
@export var max_points: float = 100
@export var target_path: NodePath

var _points_creation_time : Array[float] = []
var _last_point := Vector2.ZERO
var _clock := 0.0
var _offset := 0.0

@onready var target: Node2D = get_node_or_null(target_path)


func _ready() -> void:
	if not target:
		target = get_parent() as Node2D
	
	if Engine.is_editor_hint():
		set_process(false)
		return

	_offset = position.length()
	set_as_top_level(true)
	clear_points()
	position = Vector2.ZERO
	_last_point = to_local(target.global_position) + calculate_offset()


func _process(delta: float) -> void:
	_clock += delta
	remove_older()

	if not is_emitting:
		return

	# Adding new points if necessary.
	var desired_point := to_local(target.global_position)
	var distance: float = _last_point.distance_to(desired_point)
	if distance > resolution:
		add_timed_point(desired_point, _clock)


# Creates a new point and stores its creation time.
func add_timed_point(point: Vector2, time: float) -> void:
	add_point(point + calculate_offset())
	_points_creation_time.append(time)
	_last_point = point
	if get_point_count() > max_points:
		remove_first_point()


# Calculates the offset of the trail from its target.
func calculate_offset() -> Vector2:
	return - 1.0 * Vector2.from_angle(target.rotation).rotated(- PI / 2)* _offset


# Removes the first point in the line and the corresponding time.
func remove_first_point() -> void:
	if get_point_count() > 1:
		remove_point(0)
	_points_creation_time.pop_front()


# Remove points older than `lifetime`.
func remove_older() -> void:
	for creation_time  in _points_creation_time:
		var delta: float = _clock - creation_time
		if delta > lifetime:
			remove_first_point()
		# Points in `_points_creation_time` are ordered from oldest to newest so as soon as a point
		# isn't older than `lifetime`, we know all remaining points should stay as well.
		else:
			break


func set_emitting(emitting: bool) -> void:
	is_emitting = emitting
	if Engine.is_editor_hint():
		return
	
	if not is_inside_tree():
		await self.ready
	
	if is_emitting:
		clear_points()
		_points_creation_time.clear()
		_last_point = to_local(target.global_position) + calculate_offset()
