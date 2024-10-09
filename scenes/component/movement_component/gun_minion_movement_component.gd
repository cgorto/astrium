extends MovementComponent

@export var ammo_component: AmmoComponent
@export var targeting_component: TargetingComponent
@export var projectile_spawner_component: ProjectileSpawnerComponent
@export var orbit_distance: int = 200
@export var too_close: int = 100
@export var transition_range: float = 150

@onready var player: Node2D = get_tree().get_first_node_in_group("player")


func get_movement() -> Vector2:
	if ammo_component.current_ammo > 0:
		if targeting_component.target != null:
			var to_target: Vector2 = targeting_component.target.global_position - owner.global_position
			if to_target.length() < too_close:
				return - to_target.normalized()
			else:
				var target_velocity: VelocityComponent = targeting_component.target.get_node_or_null("VelocityComponent") as VelocityComponent
				var lead_vector: Vector2 = Vector2.ZERO
				if target_velocity != null:
					var time_to_target: float = owner.global_position.distance_to(targeting_component.target.global_position) / projectile_spawner_component.proj_speed
					lead_vector = target_velocity.velocity * time_to_target
				return to_target + lead_vector 
		else:
			return get_orbit()
	else:
		return (player.global_position - owner.global_position).normalized()


func get_orbit() -> Vector2:
	var to_player: Vector2 = player.global_position - owner.global_position
	var distance: float = to_player.length()
	
	var radial: Vector2 = to_player.normalized()
	var tangential: Vector2 = radial.rotated(PI/2)
	
	var t: float = clamp((distance - (orbit_distance - transition_range)) / (2 * transition_range), 0.0, 1.0)
	
	if distance > orbit_distance + transition_range:
		return radial
	elif distance < orbit_distance - transition_range:
		return -radial
	else:
		return lerp(tangential, radial, t)
