class_name HealthBarComponent extends ProgressBar

@export var health_component: HealthComponent

func _ready() -> void:
	health_component.health_changed.connect(on_health_changed)
	
func on_health_changed() -> void:

	value = health_component.get_health_percent()

func set_hp_percent(new_value: float) -> void:
	value = new_value
