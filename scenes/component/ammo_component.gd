class_name AmmoComponent extends Node

signal reloaded

@export var max_ammo: int = 10

@onready var reload_timer: Timer = $Reload

var current_ammo: int = 0

func _ready() -> void:
	current_ammo = max_ammo

func can_shoot() -> bool:
	return current_ammo > 0 && reload_timer.is_stopped()


func _on_reload_timeout() -> void:
	current_ammo = max_ammo
	reloaded.emit()

func consume_ammo() -> void:
	current_ammo -= 1
