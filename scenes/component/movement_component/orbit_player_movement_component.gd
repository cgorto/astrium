class_name OrbitPlayerMovementComponent extends MovementComponent

@export var orbit_distance: int = 500
@export var transition_range: float = 150

@onready var player: Node2D = get_tree().get_first_node_in_group("player")

func get_movement() -> Vector2:
	var to_player: Vector2 = player.global_position - owner.global_position
	var distance: float = to_player.length()
	
	var radial: Vector2 = to_player.normalized()
	var tangential: Vector2 = radial.rotated(PI/2)
	
	var t: float = clamp((distance - (orbit_distance - transition_range)) / (2 * transition_range), 0.0, 1.0)
	
	if distance > orbit_distance + transition_range:
		return radial
	elif distance < orbit_distance - transition_range:
		return -radial
	else:
		return lerp(tangential, radial, t)
