class_name AOE extends Node2D

@onready var hitbox_component: HitboxComponent = $HitboxComponent
@onready var timer: Timer = $Timer


func _on_timer_timeout() -> void:
	queue_free()
