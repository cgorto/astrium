extends Node

var spawn_radius: int = 500

@export var enemy_scene: PackedScene

@onready var timer: Timer = $Timer

var base_spawn_time: int = 0
var enemy_table: int = 0 
