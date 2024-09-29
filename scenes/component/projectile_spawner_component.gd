class_name ProjectileSpawnerComponent extends Node

signal projectile_spawned(projectile: Node2D)

@export var projectile_scene: PackedScene
@export var spawn_offset: Marker2D
@export var rotation_component: RotationComponent
@export var spread_angle: float = 0.0
@export var proj_per_shot: int = 1
@export var proj_speed: int = 500
@export var proj_damage: int = 10

func spawn_projectile() -> void:
	var spawn_position: Vector2 = (owner as Node2D).global_position if spawn_offset == null else spawn_offset.global_position
	var rotation: float = 0
	if rotation_component != null:
		rotation = rotation_component.pivot_node.global_rotation
	else:
		rotation = (owner as Node2D).global_rotation
	#var entities_layer: Node2D = get_tree().get_first_node_in_group("entities_layer")
	var main:Node = get_tree().current_scene
	
	for i in range(proj_per_shot):
		var projectile_instance: Projectile = projectile_scene.instantiate() as Node2D
		projectile_instance.global_position = spawn_position
		projectile_instance.rotation = rotation
		main.add_child(projectile_instance)
		projectile_instance.velocity_component.velocity = Vector2.RIGHT.rotated(rotation) * proj_speed
		
		#
