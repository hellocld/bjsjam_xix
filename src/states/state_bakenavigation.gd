class_name StateBakeNavigation
extends GameState


func state_start() -> void:
	print_debug("Baking room...")
	EventBus.map_baked.connect(_on_room_baked)
	_state_machine.game._room.rebake_room_navigation()


func _on_room_baked() -> void:
	print_debug("Room baked")
	_state_machine.change_state.call_deferred(StateNavigator.new(_state_machine))
