class_name CompositeSteeringComponent extends SteeringComponent

@export var steering_components: Dictionary[SteeringComponent, float]

func add_behavior(steering: SteeringComponent, weight: float) -> void:
	steering_components[steering] = weight

func calculate() -> Vector2:
	var steering: Vector2 = Vector2.ZERO
	for sc: SteeringComponent in steering_components.keys():
		steering += sc.calculate() * steering_components[sc]
	return steering.normalized()
