class_name BasicSpawnerComponent extends Node

@export var to_spawn_scene: PackedScene

func spawn() -> void:
	var spawn_position: Vector2 = (owner as Node2D).global_position
	var to_spawn: Node2D = to_spawn_scene.instantiate()
	var main:Node = get_tree().current_scene
	to_spawn.global_position = spawn_position
	main.add_child(to_spawn)
