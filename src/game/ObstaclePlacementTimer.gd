extends Timer


func _ready() -> void:
	EventBus.obstacle_placement_started.connect(_on_placement_started)
	timeout.connect(_on_timeout)


func _on_placement_started() -> void:
	start()


func _on_timeout() -> void:
	EventBus.obstacle_placement_timeout.emit()
