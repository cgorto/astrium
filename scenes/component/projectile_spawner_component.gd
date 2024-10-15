class_name ProjectileSpawnerComponent extends Node

signal projectile_spawned(projectile: Node2D)

@export var projectile_scene: PackedScene
@export var spawn_offset: Marker2D
@export var rotation_component: RotationComponent
@export_range(0,1,0.01) var spread_angle: float = 0.0
@export var proj_per_shot: int = 1
@export var proj_speed: int = 500
@export var proj_damage: int = 10

func spawn_projectile() -> Array[Node2D]:
	var spawn_position: Vector2 = (owner as Node2D).global_position if spawn_offset == null else spawn_offset.global_position
	var rotation: float = 0
	if rotation_component != null:
		rotation = rotation_component.pivot_node.global_rotation
	else:
		rotation = (owner as Node2D).global_rotation
	#var entities_layer: Node2D = get_tree().get_first_node_in_group("entities_layer")
	var main:Node = get_tree().current_scene
	var projs_spawned: Array[Node2D]
	
	for i in proj_per_shot:
		var projectile_instance: Node2D = projectile_scene.instantiate() as Node2D
		projectile_instance.global_position = spawn_position
		projectile_instance.rotation = rotation
		main.add_child(projectile_instance)
		var rand_spread: float = randf_range(-PI * spread_angle,PI * spread_angle)
		projectile_instance.velocity_component.velocity = Vector2.RIGHT.rotated(rotation + rand_spread) * proj_speed
		projs_spawned.append(projectile_instance)
	return projs_spawned
