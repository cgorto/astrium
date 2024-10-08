class_name EnemyManager extends Node

signal boss_progress_updated(current_progress: int, target_progress: int)

var spawn_radius: int = 500

@export var enemy_scene: PackedScene
@export var boss_scene: PackedScene
@export var boss_threshold: int = 5
@export var enemy_container: Node

@onready var timer: Timer = $Timer

var base_spawn_time: int = 0
var enemy_table: int = 0 
var number_to_spawn: int = 5
var current_boss_threshold: int = 0
var is_boss_spawned: bool = false

func _ready() -> void:
	GameEvents.resource_collected.connect(on_resource_collected)

func get_spawn_position() -> Vector2:
	var player: Node2D = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		print("what")
		return Vector2.ZERO
	
	var spawn_position: Vector2 = Vector2.ZERO
	var random_direction: Vector2 = Vector2.RIGHT.rotated(randf_range(0, TAU))
	for i in 4:
		spawn_position = player.global_position + (random_direction * spawn_radius)
		var additional_check_offset: Vector2 = random_direction * 20

		var query_paramaters:  PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position + additional_check_offset, 1)
		var result: = get_tree().root.world_2d.direct_space_state.intersect_ray(query_paramaters)

		if result.is_empty():
			break
		else:
			random_direction = random_direction.rotated(deg_to_rad(90))
	
	return spawn_position


func _on_timer_timeout() -> void:
	timer.start()
	
	var player: Node2D = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	for i in number_to_spawn:
		var enemy: Node2D = enemy_scene.instantiate() as Node2D
		enemy.global_position = get_spawn_position()
		enemy_container.add_child(enemy)
	
	
func on_resource_collected(amt: int) -> void:
	current_boss_threshold += amt
	if current_boss_threshold >= boss_threshold && not is_boss_spawned:
		is_boss_spawned = true
		var boss: Node2D = boss_scene.instantiate()
		boss.global_position = get_spawn_position()
		enemy_container.add_child.call_deferred(boss)
	boss_progress_updated.emit(current_boss_threshold,boss_threshold)
