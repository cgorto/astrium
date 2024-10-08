class_name DropOnDeathComponent extends Node

@export var value: int = 1
@export_range(0,1) var drop_percent: float = 0.5
@export var health_component: HealthComponent
@export var gold_scene: PackedScene
@export var multi_drop: bool = false
@export var multi_drop_amt: int = 3

@onready var combo_manager: ComboManager = get_tree().get_first_node_in_group("combo")

var has_dropped: bool = false

func _ready() -> void:
	(health_component as HealthComponent).died.connect(on_died)
	
func on_died(thing_died: Node2D) -> void:
	if has_dropped:
		return
	var adjusted_drop_percent:= drop_percent
	
	if randf() > adjusted_drop_percent:
		return
	
	if gold_scene == null:
		return
	
	if not owner is Node2D:
		return
		
	var spawn_position: Vector2 = (owner as Node2D).global_position
	var multi_drop_loop: int = multi_drop_amt if multi_drop else 1
	if combo_manager && multi_drop:
		multi_drop_loop *= (combo_manager.combo + 1)
	var entities_layer: Node = get_tree().current_scene
	for i in multi_drop_loop:
		
		var gold_instance: Node2D = gold_scene.instantiate() as Node2D
		entities_layer.add_child(gold_instance)
		gold_instance.global_position = spawn_position + Vector2.RIGHT.rotated(randf()*TAU) * randf_range(0,50)
	has_dropped = true
