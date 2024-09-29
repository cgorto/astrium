class_name RangeComponent extends Area2D

@export var range_size: int = 500

var in_range: Array[Node2D]

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	if collision_shape != null and collision_shape.shape is CircleShape2D:
		collision_shape.shape.radius = range_size

func _on_area_entered(area: Area2D) -> void:
	if not area is HurtboxComponent:
		return
	var hurtbox: HurtboxComponent = area as HurtboxComponent
	in_range.append(hurtbox.owner)
	if hurtbox.health_component != null:
		hurtbox.health_component.died.connect(died_in_range)
	
func _on_area_exited(area: Area2D) -> void:
	if not area is HurtboxComponent:
		return
	var hurtbox: HurtboxComponent = area as HurtboxComponent
	if hurtbox.owner in in_range:
		in_range.erase(hurtbox.owner)
		if hurtbox.health_component != null:
			hurtbox.health_component.died.disconnect(died_in_range)

func died_in_range(died: Node2D) -> void:
	if died in in_range:
		in_range.erase(died)
