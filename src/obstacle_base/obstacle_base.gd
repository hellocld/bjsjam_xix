class_name Obstacle
extends RigidBody3D

var _held: bool = true


func _ready() -> void:
	EventBus.obstacle_placement_timeout.connect(on_placement_timeout)
	for child in get_children():
		if child is CollisionShape3D:
			child.disabled = true


func place() -> void:
	_held = false
	freeze = false
	for child in get_children():
		if child is CollisionShape3D:
			child.disabled = false


func on_placement_timeout() -> void:
	# disable physics, where it is is where it is!
	freeze = true
