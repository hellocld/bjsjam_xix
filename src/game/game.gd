class_name Game
extends Node3D


@export var room_pool: Array[PackedScene]

@onready var _room_root: Node3D = $RoomRoot

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



