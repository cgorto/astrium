extends Node2D

@export var max_minions: int

@export var current_minions: Array[Node2D]

func _on_targeting_component_target_changed(new_target: Node2D) -> void:
	for minion in current_minions:
		var minion_target_component: TargetingComponent = minion.get_node_or_null("TargetingComponent") as TargetingComponent
		minion_target_component.target = new_target
