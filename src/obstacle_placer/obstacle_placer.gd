class_name ObstaclePlacer
extends Node3D

@onready var remote_trans:RemoteTransform3D = $RemoteTransform3D

@export var move_speed: float = 3.0
@export var rot_speed: float = 5.0
@export var obstacle_root:Node3D
@export var obstacles: Array[PackedScene]

var _obstacle_pool_index:int = 0:
	get:
		return _obstacle_pool_index
	set(value):
		_obstacle_pool_index = value
		instance_held_obstacle(obstacles[_obstacle_pool_index])

var _held_obstacle: Obstacle = null


func _ready() -> void:
	EventBus.room_ready.connect(instance_held_obstacle.bind(obstacles[_obstacle_pool_index]))


func _physics_process(delta):
	var movement = Vector3.ZERO
	var rot_x = Input.get_axis("obstacleplacer_rot_x_pos", "obstacleplacer_rot_x_neg")
	var rot_z = Input.get_axis("obstacleplacer_rot_z_pos", "obstacleplacer_rot_z_neg")
	movement.x = Input.get_axis("obstacleplacer_move_left", "obstacleplacer_move_right")
	movement.z = Input.get_axis("obstacleplacer_move_up", "obstacleplacer_move_down")
	translate(movement * move_speed * delta)
	remote_trans.rotate_x(rot_x * rot_speed * delta)
	remote_trans.rotate_z(rot_z * rot_speed * delta)
	
	if Input.is_action_just_pressed("obstacleplacer_previous_obstacle"):
		_obstacle_pool_index = wrapi(_obstacle_pool_index + 1, 0, obstacles.size())
	if Input.is_action_just_pressed("obstacleplacer_next_obstacle"):
		_obstacle_pool_index = wrapi(_obstacle_pool_index - 1, 0, obstacles.size())
	
	if Input.is_action_just_pressed("obstacleplacer_place"):
		_held_obstacle.place()
		_held_obstacle = null
		instance_held_obstacle(obstacles[_obstacle_pool_index])


func instance_held_obstacle(obstacleScene: PackedScene) -> void:
	var temp = obstacleScene.instantiate()
	if !(temp is Obstacle):
		print_debug("ERROR: invalid obstacle instance attempt: %s" % temp.name)
		return
	remote_trans.remote_path = ""
	if _held_obstacle != null:
		_held_obstacle.queue_free()
	_held_obstacle = temp
	obstacle_root.add_child(_held_obstacle)
	remote_trans.remote_path = _held_obstacle.get_path()


