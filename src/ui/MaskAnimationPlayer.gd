extends AnimationPlayer


func mask_shown() -> void:
	EventBus.ui_mask_shown.emit()


func mask_hidden() -> void:
	EventBus.ui_mask_hidden.emit()
