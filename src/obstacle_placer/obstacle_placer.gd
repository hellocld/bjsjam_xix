class_name ObstaclePlacer
extends Node3D

@onready var remote_trans:RemoteTransform3D = $RemoteTransform3D

@export var move_speed: float = 3.0
@export var rot_speed: float = 5.0

var _held_obstacle: Obstacle = null
var _obstacle_root: Node3D:
	get:
		if _obstacle_root == null:
			_obstacle_root = get_tree().get_nodes_in_group("ObstacleRoot")[0]
		return _obstacle_root


func _physics_process(delta):
	var movement = Vector3.ZERO
	var rot_x = Input.get_axis("obstacleplacer_rot_x_pos", "obstacleplacer_rot_x_neg")
	var rot_z = Input.get_axis("obstacleplacer_rot_z_pos", "obstacleplacer_rot_z_neg")
	movement.x = Input.get_axis("obstacleplacer_move_left", "obstacleplacer_move_right")
	movement.z = Input.get_axis("obstacleplacer_move_up", "obstacleplacer_move_down")
	translate(movement * move_speed * delta)
	remote_trans.rotate_x(rot_x * rot_speed * delta)
	remote_trans.rotate_z(rot_z * rot_speed * delta)


func instance_held_obstacle(obstacleScene: PackedScene) -> void:
	var temp = obstacleScene.instantiate()
	if !(temp is Obstacle):
		print_debug("ERROR: invalid obstacle instance attempt: %s" % temp.name)
		return
	remote_trans.remote_path = ""
	_held_obstacle.queue_free()
	_held_obstacle = temp
	_obstacle_root.add_child(_held_obstacle)
	remote_trans.remote_path = _held_obstacle.get_path()
	remote_trans.rotation = Vector3.ZERO
