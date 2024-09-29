class_name HurtboxComponent extends Area2D

signal hit

@export var health_component: HealthComponent



func _on_area_entered(other_area: Area2D) -> void:
	if not other_area is HitboxComponent:
		return
	if health_component == null:
		return

	var hitbox_component: HitboxComponent = other_area as HitboxComponent
	#TODO: When health component is done
	health_component.damage(hitbox_component.damage)
	hitbox_component.hit.emit(self)
	hit.emit()
