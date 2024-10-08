extends CanvasLayer

@onready var progress_bar: ProgressBar = $MarginContainer/ProgressBar

func _ready() -> void:
	progress_bar.value = 0

func update_progress(current_progress: int, target_progress: int) -> void:
	var percent: float = current_progress / target_progress
	progress_bar. value = percent
