class_name ComboManager extends Node

signal combo_updated(new_combo: int)
#TODO: maybe add time out for combo, maybe not

var combo: int = 0


func _ready() -> void:
	GameEvents.last_hit.connect(on_last_hit)

func on_last_hit(hit: bool) -> void:
	if not hit:
		combo = 0
	else:
		combo += 1
	combo_updated.emit(combo)
