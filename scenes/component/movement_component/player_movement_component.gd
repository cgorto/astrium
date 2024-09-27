class_name PlayerMovementComponent extends MovementComponent

func get_movement() -> Vector2:
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	var direction: Vector2 = input_dir.normalized()
	return direction
