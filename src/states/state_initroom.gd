class_name StateInitRoom
extends GameState


func state_start() -> void:
	EventBus.ui_mask_shown.connect(_on_mask_shown, CONNECT_ONE_SHOT)
	EventBus.room_ready.connect(_on_room_ready, CONNECT_ONE_SHOT)
	_state_machine.ui.mask_show()


func state_end() -> void:
	pass


func _on_mask_shown() -> void:
	_state_machine.ui.hide_main_menu()
	_state_machine.game.instance_random_room()


func _on_room_ready() -> void:
	_state_machine.ui.mask_hide()
	_state_machine.change_state.call_deferred(StateObstaclePlacement.new(_state_machine))
