extends CharacterBody3D

@export var move_speed: float = 3.0
@export var nav_agent: NavigationAgent3D
@export var target: Node3D

var _calc_velocity: Vector3

func _ready() -> void:
	nav_agent.target_position = target.global_position
	_calc_time_to_target.call_deferred()


func _calc_time_to_target() -> void:
	await get_tree().physics_frame
	var path = nav_agent.get_current_navigation_path()
	var distance: float = 0.0
	for i in path.size() - 1:
		distance += (path[i].distance_to(path[i + 1]) / nav_agent.max_speed)
	print_debug(distance)


func _physics_process(delta):
	var next_path_position = nav_agent.get_next_path_position()
	_calc_velocity = (next_path_position - global_position).normalized() * move_speed
	if nav_agent.avoidance_enabled:
		nav_agent.set_velocity(_calc_velocity)
	else:
		print_debug("Not using avoidance!")
		_on_navigation_agent_3d_velocity_computed(_calc_velocity)


func _on_navigation_agent_3d_target_reached():
	velocity = Vector3.ZERO


func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()
