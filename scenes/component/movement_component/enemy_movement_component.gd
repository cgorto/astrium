class_name EnemyMovementComponent extends MovementComponent

@onready var composite_steering: CompositeSteeringComponent = $Composite

func _ready() -> void:
	composite_steering.velocity_component = velocity_component
	for child in composite_steering.get_children():
		var sc: SteeringComponent = child as SteeringComponent
		sc.agent = owner
		sc.velocity_component = velocity_component

func get_movement() -> Vector2:
	return composite_steering.calculate()
