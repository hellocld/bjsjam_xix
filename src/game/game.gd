class_name Game
extends Node3D


@export var room_pool: Array[PackedScene]

@onready var _room_root: Node3D = $RoomRoot

@onready var _ui:UI = $UI

@onready var _state_machine:StateMachine = $StateMachine

var _room: RoomBase


func _ready() -> void:
	_ui.mask_hide()
	EventBus.ui_mask_hidden.connect(on_room_ready, CONNECT_ONE_SHOT)
	EventBus.map_baked.connect(_on_map_baked)


func on_room_ready() -> void:
	_ui.start_obst_countdown()


func instance_random_room() -> void:
	_room = room_pool.pick_random().instantiate() as RoomBase
	for child in _room_root.get_children():
		child.queue_free()
	_room_root.add_child(_room)


func _on_map_baked() -> void:
	_ui.mask_hide()
	_room.navigator.ready_up()
	_room.navigator.start_nav()
