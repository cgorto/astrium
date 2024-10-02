class_name Missile extends Node2D

@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var rotation_component: RotationComponent = $RotationComponent
@onready var targeting_component: TargetingComponent = $TargetingComponent

var initial_speed: int = 10

func _on_timer_timeout() -> void:
	queue_free()

func _ready() -> void:
	initial_speed = velocity_component.max_speed

func _physics_process(delta: float) -> void:
	if targeting_component.target != null:
		velocity_component.accelerate_in_direction(to_local(targeting_component.target.global_position))
		rotation_component.rotate_towards_position(targeting_component.target.global_position)
	velocity_component.move(self)


func _on_hitbox_component_hit(thing_hit: Node2D) -> void:
	queue_free()
