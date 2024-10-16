class_name EnemyCohesionSteeringComponent extends SteeringComponent

@export var cohesion_radius : float = 200

func calculate() -> Vector2:
	var center_of_mass: Vector2 = Vector2.ZERO
	var count: int = 0
	
	for e in get_tree().get_nodes_in_group("enemies"):
		var enemy: Node2D = e as Node2D
		if enemy != agent and enemy.global_position.distance_to(agent.global_position) < cohesion_radius:
			center_of_mass += enemy.global_position
			count += 1
	if count > 0:
		center_of_mass /= count
		return (center_of_mass - agent.global_position).normalized()
	return Vector2.ZERO
