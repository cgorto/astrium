class_name AOEComponent extends Node

@export var aoe_scene: PackedScene

func spawn_aoe() -> void:
	var spawn_position: Vector2 = (owner as Node2D).global_position
	var aoe: AOE = aoe_scene.instantiate()
	var main:Node = get_tree().current_scene
	aoe.global_position = spawn_position
	main.add_child(aoe)
