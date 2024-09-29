class_name TargetingComponent extends Node

signal target_changed(new_target: Node2D)

@export var range_component: RangeComponent

var target: Node2D

func _process(delta: float) -> void:
	if target == null or not is_instance_valid(target) or not target in range_component.in_range:
		select_target()
		
func select_target() -> void:
	var previous_target: Node2D = target
	if not range_component.in_range.is_empty():
		target = range_component.in_range[0]
	else:
		target = null
	if target != previous_target:
		target_changed.emit(target)
