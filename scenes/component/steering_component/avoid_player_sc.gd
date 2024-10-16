class_name AvoidPlayerSteeringComponent extends SteeringComponent

@export var avoidance_radius: float = 100

func calculate() -> Vector2:
	var distance: Vector2 = player.global_position - agent.global_position
	var length: float = distance.length()
	if length < avoidance_radius:
		return - distance.normalized()
	return Vector2.ZERO
