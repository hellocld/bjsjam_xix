class_name StateNavigator
extends GameState


func state_start() -> void:
	_state_machine.game._room.navigator.ready_up()
	_state_machine.ui.navigation_ui.initialize()
	_state_machine.ui.show_nav_ui()
	EventBus.ui_mask_hidden.connect(_on_mask_hidden, CONNECT_ONE_SHOT)
	EventBus.nav_target_reached.connect(_on_nav_target_reached, CONNECT_ONE_SHOT)
	EventBus.nav_target_failed.connect(_on_nav_failed, CONNECT_ONE_SHOT)
	EventBus.return_to_main_pressed.connect(_on_return_to_main, CONNECT_ONE_SHOT)
	_state_machine.ui.mask_hide()


func _on_mask_hidden() -> void:
	_state_machine.game._room.navigator.start_nav()


func _on_nav_target_reached() -> void:
	_state_machine.ui.navigation_ui.present_victory_results()


func _on_nav_failed() -> void:
	_state_machine.ui.navigation_ui.present_failed_results()


func _on_return_to_main() -> void:
	EventBus.ui_mask_shown.connect(_on_mask_shown, CONNECT_ONE_SHOT)
	_state_machine.ui.mask_show()


func _on_mask_shown() -> void:
	_state_machine.change_state(StateMainMenu.new(_state_machine))
