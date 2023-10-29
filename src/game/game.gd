class_name Game
extends Node3D


@export var room_pool: Array[PackedScene]

@onready var _room_root: Node3D = $RoomRoot

@onready var _ui:UI = $UI

@export var _state_machine:StateMachine

var _room: RoomBase


func _ready() -> void:
	_state_machine.change_state(StateMainMenu.new(_state_machine))


func instance_random_room() -> void:
	_room = room_pool.pick_random().instantiate() as RoomBase
	for child in _room_root.get_children():
		child.queue_free()
	_room_root.add_child(_room)
