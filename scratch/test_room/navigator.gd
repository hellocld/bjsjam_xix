extends CharacterBody3D

@export var move_speed: float = 3.0
@export var nav_agent: NavigationAgent3D
@export var target: Node3D


func _ready() -> void:
	nav_agent.target_position = target.global_position
	_set_velocity.call_deferred()
	_calc_time_to_target.call_deferred()

func _calc_time_to_target() -> void:
	await get_tree().physics_frame
	var path = nav_agent.get_current_navigation_path()
	var distance: float = 0.0
	for i in path.size() - 1:
		distance += (path[i].distance_to(path[i + 1]) / move_speed)
	print_debug(distance)


func _physics_process(delta):
	_set_velocity()
	move_and_slide()


func _set_velocity() -> void:
	await get_tree().physics_frame
	var next_position = nav_agent.get_next_path_position()
	velocity = (next_position - global_position).normalized() * move_speed


func _on_navigation_agent_3d_target_reached():
	velocity = Vector3.ZERO
