class_name UI
extends Control

var _state_machine: AnimationNodeStateMachinePlayback


func _ready() -> void:
	_state_machine = $MaskAnimationTree["parameters/playback"]
	EventBus.obstacle_placement_timeout.connect(_on_obst_placement_timeout)


func mask_hide() -> void:
	_state_machine.travel("MaskHide")


func mask_show() -> void:
	_state_machine.travel("MaskShow")


func start_obst_countdown() -> void:
	$Countdown/AnimationPlayer.play("Countdown_Obstacles")


func obst_countdown_complete() -> void:
	EventBus.obstacle_placement_started.emit()


func _on_obst_placement_timeout() -> void:
	$ObstTimesUp.visible = true
	var timer = get_tree().create_timer(3)
	timer.timeout.connect(mask_show)
	EventBus.ui_mask_shown.connect(_on_timesup_mask_shown, CONNECT_ONE_SHOT)

func _on_timesup_mask_shown() -> void:
	$ObstTimesUp.visible = false
