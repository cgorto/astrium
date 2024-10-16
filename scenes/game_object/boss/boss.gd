extends CharacterBody2D


@onready var health_component: HealthComponent = $HealthComponent
@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var movement_component: MovementComponent = $EnemyMovementComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var rotation_component: RotationComponent = $RotationComponent


func _physics_process(delta: float) -> void:
	var mvmt_dir: Vector2 = movement_component.get_movement()
	velocity_component.accelerate_in_direction(mvmt_dir)
	if mvmt_dir != Vector2.ZERO:
		rotation_component.rotate_towards_direction(mvmt_dir)
	velocity_component.move(self)
