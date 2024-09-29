extends Node2D

@onready var projectile_spawner: ProjectileSpawnerComponent = $ProjectileSpawnerComponent
@onready var rotation_component: RotationComponent = $RotationComponent
@onready var targeting_component: TargetingComponent = $TargetingComponent
@onready var range_component: RangeComponent = $RangeComponent
@onready var attack_cooldown: Timer = $AttackCooldown



func _physics_process(delta: float) -> void:
	if targeting_component.target != null:
		rotation_component.rotate_towards_position(targeting_component.target.global_position)
		if attack_cooldown.is_stopped():
			projectile_spawner.spawn_projectile()
			attack_cooldown.start()
