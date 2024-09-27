class_name RotationComponent extends Node

@export var pivot_node: Node2D
@export var rotation_speed: float = 10


func rotate_towards(dir: Vector2) -> void:
	var dir_angle: float = dir.angle()
	pivot_node.rotation = lerp_angle(pivot_node.rotation,dir_angle,rotation_speed * get_process_delta_time())
