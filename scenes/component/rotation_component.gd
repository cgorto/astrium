class_name RotationComponent extends Node

@export var pivot_node: Node2D
@export var rotation_speed: float = 10


func rotate_towards_direction(dir: Vector2) -> void:
	var dir_angle: float = dir.angle()
	pivot_node.rotation = lerp_angle(pivot_node.rotation,dir_angle,rotation_speed * get_process_delta_time())

func rotate_towards_position(target_position: Vector2) -> void:
	var owner_node: Node2D = owner as Node2D
	var dir: Vector2 = (target_position - owner_node.global_position).normalized()
	rotate_towards_direction(dir)
