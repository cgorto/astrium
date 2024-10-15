extends Node2D

@export var max_minions: int = 1

@onready var basic_spawner_component: BasicSpawnerComponent = $BasicSpawnerComponent
@onready var spawn_timer: Timer = $SpawnTimer

@export var current_minions: Array[Node2D]

func _on_targeting_component_target_changed(new_target: Node2D) -> void:
	for minion in current_minions:
		var minion_target_component: TargetingComponent = minion.get_node_or_null("TargetingComponent") as TargetingComponent
		minion_target_component.target = new_target


func _on_reload_area_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent:
		if area.owner in current_minions:
			#check if ammo out
			start_reload(area.owner)


func start_reload(to_reload: Node2D) -> void:
	pass
