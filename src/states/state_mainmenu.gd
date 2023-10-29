class_name StateMainMenu
extends GameState


func state_start() -> void:
	# Configure UI
	_state_machine.ui.game_start_pressed.connect(_on_game_start_clicked)
	_state_machine.ui.show_main_menu()
	_state_machine.ui.mask_hide()


func state_process(delta) -> void:
	pass


func state_end() -> void:
	_state_machine.ui.mask_show()


func _on_game_start_clicked() -> void:
	_state_machine.change_state.call_deferred(StateInitRoom.new(_state_machine))
