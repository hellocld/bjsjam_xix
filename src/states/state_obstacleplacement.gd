class_name StateObstaclePlacement
extends GameState


func state_start() -> void:
	EventBus.obstacle_placement_timeout.connect(_on_obstacle_placement_timeout)
	_state_machine.ui.obstacle_ui.initialize()
	_state_machine.ui.show_obst_ui()
	_state_machine.ui.obstacle_ui.start_obst_countdown()


func _on_obstacle_placement_timeout() -> void:
	var timer = _state_machine.get_tree().create_timer(3)
	timer.timeout.connect(_state_machine.ui.mask_show, CONNECT_ONE_SHOT)
	EventBus.ui_mask_shown.connect(_on_timesup_mask_shown, CONNECT_ONE_SHOT)


func _on_timesup_mask_shown() -> void:
	_state_machine.ui.hide_obst_ui()
	_state_machine.change_state.call_deferred(StateBakeNavigation.new(_state_machine))
