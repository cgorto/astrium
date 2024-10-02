class_name VelocityComponent extends Node

@export var max_speed: int = 50
@export var acceleration: float = 5

var velocity: Vector2 = Vector2.ZERO

func accelerate_to_player() -> void:
	var owner_node2d: = owner as Node2D
	if owner_node2d == null:
		return
	var player: = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	var direction: Vector2 = (player.global_position - owner_node2d.global_position).normalized()
	accelerate_in_direction(direction)
	

func accelerate_in_direction(direction: Vector2) -> void:
	
	var desired_velocity:Vector2 = direction.normalized() * max_speed
	velocity = velocity.lerp(desired_velocity, 1 - exp(-acceleration *get_physics_process_delta_time()))
	
func decelerate() -> void:
	accelerate_in_direction(Vector2.ZERO)

func move(to_move: Node2D) -> void:
	if to_move is CharacterBody2D:
		to_move.velocity = velocity
		to_move.move_and_slide()
		velocity = to_move.velocity
	else:
		to_move.position += velocity * get_physics_process_delta_time()
