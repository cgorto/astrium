class_name HitboxComponent extends Area2D

signal hit(thing_hit: Node2D)

@export var damage: int = 0

func set_hitbox(layer_to_hit: int, new_damage: int) -> void:
	set_collision_layer_value(layer_to_hit, true)
	damage = new_damage
