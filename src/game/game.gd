class_name Game
extends Node3D


@export var room_pool: Array[PackedScene]

@onready var _room_root: Node3D = $RoomRoot

@onready var _ui:UI = $UI

@export var _state_machine:StateMachine

var _room: RoomBase

var nav_stopwatch: float
var _nav_stopwatch_running:= false


func _ready() -> void:
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
	_state_machine.change_state(StateMainMenu.new(_state_machine))
	EventBus.nav_navigation_started.connect(start_nav_stopwatch)
	EventBus.nav_target_reached.connect(stop_nav_stopwatch)
	EventBus.nav_target_failed.connect(stop_nav_stopwatch)


func _process(delta) -> void:
	if _nav_stopwatch_running:
		nav_stopwatch += delta


func instance_random_room() -> void:
	_room = room_pool.pick_random().instantiate() as RoomBase
	for child in _room_root.get_children():
		child.queue_free()
	_room_root.add_child(_room)


func start_nav_stopwatch() -> void:
	nav_stopwatch = 0
	_nav_stopwatch_running = true


func stop_nav_stopwatch() -> void:
	_nav_stopwatch_running = false
