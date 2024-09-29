extends Node

@onready var timer: Timer = $Timer

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if timer.is_inside_tree():
		timer.start()


func _on_timer_timeout() -> void:
	owner.queue_free()
	
