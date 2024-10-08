extends CanvasLayer

@export var enemy_manager: EnemyManager
@onready var progress_bar: ProgressBar = $MarginContainer/ProgressBar

func _ready() -> void:
	progress_bar.value = 0
	enemy_manager.boss_progress_updated.connect(update_progress)

func update_progress(current_progress: int, target_progress: int) -> void:
	
	var percent: float = (current_progress as float) / (target_progress as float)
	progress_bar.value = percent
