class_name Navigator
extends CharacterBody3D

@export var move_speed: float = 3.0
@export var nav_agent: NavigationAgent3D
@export var target: Node3D

var _calc_velocity: Vector3
var _is_navigating:bool = false


func configure(start:Node3D, goal:Node3D) -> void:
	global_transform = start.global_transform
	nav_agent.target_position = goal.global_position
	visible = false


func ready_up() -> void:
	visible = true


func start_nav() -> void:
	EventBus.nav_navigation_started.emit()
	_is_navigating = true


func is_target_reachable() -> bool:
	return nav_agent.is_target_reachable()


func _calc_time_to_target() -> void:
	await get_tree().physics_frame
	var path = nav_agent.get_current_navigation_path()
	var distance: float = 0.0
	for i in path.size() - 1:
		distance += (path[i].distance_to(path[i + 1]) / nav_agent.max_speed)
	print_debug(distance)


func _physics_process(delta):
	if !_is_navigating:
		return
	if velocity.length_squared() > 0:
		look_at(global_position + velocity)
	var next_path_position = nav_agent.get_next_path_position()
	_calc_velocity = (next_path_position - global_position).normalized() * move_speed
	if nav_agent.avoidance_enabled:
		nav_agent.set_velocity(_calc_velocity)
	else:
		_on_navigation_agent_3d_velocity_computed(_calc_velocity)


func _on_navigation_agent_3d_target_reached():
	EventBus.nav_target_reached.emit()


func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()


func _on_navigation_agent_3d_navigation_finished():
	if !nav_agent.is_target_reached():
		EventBus.nav_target_failed.emit()
	velocity = Vector3.ZERO
	_is_navigating = false
