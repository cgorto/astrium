extends Node

signal difficulty_increased(new_difficulty: int)

var difficulty: int = 1



func _on_timer_timeout() -> void:
	difficulty += 1
	difficulty_increased.emit(difficulty)
