class_name SteeringComponent extends Node

@export var agent: Node2D
@export var velocity_component: VelocityComponent

@onready var player: Node2D = get_tree().get_first_node_in_group("player") as Node2D

func calculate() -> Vector2:
	return Vector2.ZERO
