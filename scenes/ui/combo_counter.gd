extends CanvasLayer

@export var combo_manager: ComboManager
@onready var combo_counter: Label = $HBoxContainer/Label2

func _ready() -> void:
	combo_counter.text = str(0)
	combo_manager.combo_updated.connect(update_combo)
	
	
func update_combo(new_combo: int) -> void:
	combo_counter.text = str(new_combo)
