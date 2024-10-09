class_name Projectile extends Node2D

@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var hitbox_component: HitboxComponent = $HitboxComponent



func _physics_process(delta: float) -> void:
	velocity_component.move(self)


func _on_hitbox_component_hit(thing_hit: Node2D) -> void:
	queue_free()


	
