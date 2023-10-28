extends Label


@export var timer:Timer


func _ready() -> void:
	EventBus.obstacle_placement_started.connect(_on_timer_started)
	EventBus.obstacle_placement_timeout.connect(_on_timer_timeout)


func _process(delta):
	var minutes:int = (timer.time_left as int) / 60
	var seconds:int = (timer.time_left as int) % 60
	text = "%02d:%02d" % [minutes, seconds]


func _on_timer_started() -> void:
	visible = true


func _on_timer_timeout() -> void:
	visible = false
