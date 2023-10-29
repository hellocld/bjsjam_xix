class_name ObstacleUI
extends Control

@export var timer:Control
@export var times_up:Control
@export var countdown:Control
@export var countdown_animator:AnimationPlayer

func _ready() -> void:
	EventBus.obstacle_placement_timeout.connect(_on_obstacle_placement_timeout)


func initialize() -> void:
	timer.visible = true
	times_up.visible = false
	countdown.visible = true


func start_obst_countdown() -> void:
	countdown_animator.play("Countdown_Obstacles")


func _on_obstacle_placement_timeout() -> void:
	times_up.visible = true


func obst_countdown_complete() -> void:
	EventBus.obstacle_placement_started.emit()
	countdown.visible = false
