class_name StateMachine
extends Node

@onready var game:Game = $".."
@onready var ui:UI = $"../UI"

var _current_state: GameState


func change_state(new_state:GameState) -> void:
	_current_state = new_state
	_current_state.state_start()


func _process(delta) -> void:
	_current_state.state_process(delta)
