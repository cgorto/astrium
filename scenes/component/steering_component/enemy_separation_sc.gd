class_name EnemySeparationSteeringComponent extends SteeringComponent

@export var separation_radius: float = 50

func calculate() -> Vector2:
	var separation: Vector2 = Vector2.ZERO
	
	for e in get_tree().get_nodes_in_group("enemies"):
		var enemy: Node2D = e as Node2D
		if enemy != agent:
			var to_enemy: Vector2 = agent.global_position - enemy.global_position
			var distance: float = to_enemy.length()
			if distance < separation_radius:
				separation += to_enemy.normalized() / distance
	
	return separation.normalized()
