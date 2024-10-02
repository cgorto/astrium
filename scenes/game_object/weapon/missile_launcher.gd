extends Node2D

@onready var projectile_spawner: ProjectileSpawnerComponent = $ProjectileSpawnerComponent
@onready var targeting_component: TargetingComponent = $TargetingComponent
@onready var range_component: RangeComponent = $RangeComponent
@onready var attack_cooldown: Timer = $AttackCooldown



func _physics_process(delta: float) -> void:
	if targeting_component.target != null:
		if attack_cooldown.is_stopped():
			var projs_spawned: Array[Node2D] = projectile_spawner.spawn_projectile() as Array[Node2D]
			for proj in projs_spawned:
				var missile: Missile = proj as Missile
				missile.targeting_component.target = targeting_component.target
			attack_cooldown.start()
