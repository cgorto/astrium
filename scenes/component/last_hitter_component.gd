class_name LastHitterComponent extends Node2D

@export var cooldown_time: float = 5.0
@onready var cooldown_timer: Timer = $MissCooldown
@onready var line: Line2D = $Line2D
@onready var visible_timer: Timer = $Line2D/VisibleTimer

var target_global_position: Vector2 = Vector2.ZERO

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if not cooldown_timer.is_stopped():
			return
		var space_state:PhysicsDirectSpaceState2D = get_world_2d().direct_space_state
		var query: = PhysicsPointQueryParameters2D.new()
		query.position = get_global_mouse_position()
		
		target_global_position = query.position
		line.visible = true
		visible_timer.start()
		
		
		query.collision_mask = 8
		query.collide_with_areas = true
		var result: = space_state.intersect_point(query)
		
		if result:
			for collision in result:
				var collider: Area2D = collision.collider
				if collider is LastHitOrb:
					collider.last_hit()
					GameEvents.last_hit.emit(true)
				else:
					GameEvents.last_hit.emit(false)
		else:
			GameEvents.last_hit.emit(false)

func _process(delta: float) -> void:
	if line.visible:
		var local_position: Vector2 = to_local(target_global_position)
		line.points = [Vector2.ZERO, local_position]


func _on_visible_timer_timeout() -> void:
	line.visible = false
	
