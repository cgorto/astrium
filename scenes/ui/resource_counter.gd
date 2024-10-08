extends CanvasLayer

@export var resource_manager: MissionResourceManager
@onready var resource_counter: Label = $VBoxContainer/HBoxContainer/Label2

func _ready() -> void:
	resource_counter.text = str(0)
	resource_manager.resource_updated.connect(update_counter)

func update_counter(new_amt: int) -> void:
	resource_counter.text = str(new_amt)
