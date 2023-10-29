class_name GameState
extends RefCounted


var _state_machine:StateMachine


func _init(state_machine:StateMachine) -> void:
	pass


func state_start() -> void:
	pass


func state_process(delta) -> void:
	pass


func state_end() -> void:
	pass
