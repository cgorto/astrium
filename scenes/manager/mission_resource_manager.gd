class_name MissionResourceManager extends Node

@export var death_mult: float = 0.0
@export var leave_early_mult: float = 0.5

var collected_resources: int = 0


func _ready() -> void:
	GameEvents.resource_collected.connect(on_resource_collected)

func add_resources(amount: int) -> void:
	collected_resources += amount
	print(collected_resources)

func clear_resources() -> void:
	collected_resources = 0
	
func get_death_resources() -> int:
	return collected_resources * death_mult
	
func get_leave_early_resources() -> int:
	return collected_resources * leave_early_mult

func on_resource_collected(amt: int) -> void:
	add_resources(amt)
