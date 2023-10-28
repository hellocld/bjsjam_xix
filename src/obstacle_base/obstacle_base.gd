class_name Obstacle
extends RigidBody3D

var _held: bool = true


func on_dropped() -> void:
	# 
	_held = false
	freeze = false


func on_placement_timeout() -> void:
	# disable physics, where it is is where it is!
	freeze = true
