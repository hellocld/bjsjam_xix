class_name StateNavigator
extends GameState


func state_start() -> void:
	_state_machine.game._room.navigator.ready_up()
	EventBus.ui_mask_hidden.connect(_on_mask_hidden, CONNECT_ONE_SHOT)
	_state_machine.ui.mask_hide()


func _on_mask_hidden() -> void:
	# Start the timer
	# Get navigating!
	pass
