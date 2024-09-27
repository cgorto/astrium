class_name Gold extends Area2D

@export var value: int = 1
var attracted_by: Node2D
var current_speed: int = 400

func _physics_process(delta: float) -> void:
	if attracted_by != null:
		#don't think we need vel comp
		global_position = global_position.move_toward(attracted_by.global_position, delta * current_speed)
		current_speed += 20

func pickup() -> void:
	pass
