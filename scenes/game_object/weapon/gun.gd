extends Node2D

@onready var projectile_spawner: ProjectileSpawnerComponent = $ProjectileSpawnerComponent
@onready var rotation_component: RotationComponent = $RotationComponent
@onready var targeting_component: TargetingComponent = $TargetingComponent
@onready var range_component: RangeComponent = $RangeComponent
@onready var attack_cooldown: Timer = $AttackCooldown

@export var lead_coef: float = 1



func _physics_process(delta: float) -> void:
	if targeting_component.target != null:
		var target_velocity: VelocityComponent = targeting_component.target.get_node_or_null("VelocityComponent") as VelocityComponent
		var lead_vector: Vector2 = Vector2.ZERO
		if target_velocity != null:
			var time_to_target: float = global_position.distance_to(targeting_component.target.global_position) / projectile_spawner.proj_speed
			lead_vector = target_velocity.velocity * time_to_target
			
		rotation_component.rotate_towards_position(targeting_component.target.global_position + lead_vector * lead_coef)
		if attack_cooldown.is_stopped():
			projectile_spawner.spawn_projectile()
			attack_cooldown.start()
