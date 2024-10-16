class_name PursuePlayerSteeringComponent extends SteeringComponent

@export var max_prediction_time : float = 1.0

func calculate() -> Vector2:
	var distance: Vector2 = player.global_position - agent.global_position
	var prediction_time: float = distance.length() / velocity_component.max_speed
	prediction_time = min(prediction_time, max_prediction_time)
	
	var predicted_pos: Vector2 = player.global_position + player.velocity_component.velocity * prediction_time
	return (predicted_pos - agent.global_position).normalized()
