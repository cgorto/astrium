extends Node

@export var value: int = 1
@export_range(0,1) var drop_percent: float = 0.5
@export var health_component: Node
@export var gold_scene: PackedScene

func _ready() -> void:
	(health_component as HealthComponent).died.connect(on_died)
	
func on_died(thing_died: Node2D) -> void:
	var adjusted_drop_percent:= drop_percent
	
	if randf() > adjusted_drop_percent:
		return
	
	if gold_scene == null:
		return
	
	if not owner is Node2D:
		return
		
	var spawn_position: Vector2 = (owner as Node2D).global_position
	var gold_instance: Node2D = gold_scene.instantiate() as Node2D
	var entities_layer: Node = get_tree().current_scene #Maybe make this an autoload idk
	entities_layer.add_child(gold_instance)
	gold_instance.global_position = spawn_position
	
