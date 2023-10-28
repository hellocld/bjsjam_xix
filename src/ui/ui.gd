class_name UI
extends Control

var _state_machine: AnimationNodeStateMachinePlayback


func _ready() -> void:
	_state_machine = $MaskAnimationTree["parameters/playback"]


func mask_hide() -> void:
	_state_machine.travel("MaskHide")


func mask_show() -> void:
	_state_machine.travel("MaskShow")


func start_obst_countdown() -> void:
	$Countdown/AnimationPlayer.play("Countdown_Obstacles")


func obst_countdown_complete() -> void:
	EventBus.ready_for_obstacle_placement.emit()
