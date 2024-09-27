extends Node

signal projectile_spawned(projectile)

@export var projectile_scene: PackedScene
@export var spawn_offset: Marker2D
@export var spread_angle: float = 0.0
@export var proj_per_shot: int = 1

func spawn_projectile() -> void:
	var spawn_position: Vector2 = (owner as Node2D).global_position
	var rotation: float = (owner as Node2D).global_rotation
	var projectile_instance: Node2D = projectile_scene.instantiate() as Node2D
	var entities_layer: Node2D = get_tree().get_first_node_in_group("entities_layer")
