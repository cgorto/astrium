extends CharacterBody2D

@onready var health_component: HealthComponent = $HealthComponent
@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var movement_component: MovementComponent = $MovementComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var rotation_component: RotationComponent = $RotationComponent
@onready var projectile_spawner_component: ProjectileSpawnerComponent = $ProjectileSpawnerComponent
@onready var targeting_component: TargetingComponent = $TargetingComponent
@onready var ammo_component: AmmoComponent = $AmmoComponent
@onready var attack_cooldown: Timer = $AttackCooldown

func _physics_process(delta: float) -> void:
	var mvmt_dir: Vector2 = movement_component.get_movement()
	velocity_component.accelerate_in_direction(mvmt_dir)
	if mvmt_dir != Vector2.ZERO:
		rotation_component.rotate_towards_direction(mvmt_dir)
	velocity_component.move(self)
	if targeting_component.target && attack_cooldown.is_stopped() && ammo_component.can_shoot():
		projectile_spawner_component.spawn_projectile()
		attack_cooldown.start()
		ammo_component.consume_ammo()
