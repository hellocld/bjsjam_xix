class_name Game
extends Node3D


@export var room_pool: Array[PackedScene]

@onready var _room_root: Node3D = $RoomRoot
@onready var _obstacle_placer: ObstaclePlacer = $ObstaclePlacer
@onready var _ui:UI = $UI

var _room: RoomBase


func _ready() -> void:
	_instance_random_room()
	EventBus.room_ready.emit()
	_ui.mask_hide()


func _instance_random_room() -> void:
	_room = room_pool.pick_random().instantiate() as RoomBase
	for child in _room_root.get_children():
		child.queue_free()
	_room_root.add_child(_room)


func _enable_obstacle_placer() -> void:
	if _obstacle_placer.get_parent() == null:
		add_child(_obstacle_placer)


func _disable_obstacle_placer() -> void:
	_obstacle_placer.get_parent().remove_child(_obstacle_placer)


