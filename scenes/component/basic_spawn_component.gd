class_name BasicSpawnerComponent extends Node

@export var to_spawn_scene: PackedScene
@export var spawn_container: Node

func spawn() -> void:
	var spawn_position: Vector2 = (owner as Node2D).global_position
	var to_spawn: Node2D = to_spawn_scene.instantiate()
	var main:Node = get_tree().current_scene
	if spawn_container:
		main = spawn_container
	to_spawn.global_position = spawn_position
	main.add_child(to_spawn)
