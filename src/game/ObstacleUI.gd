class_name ObstacleUI
extends Control

@export var timer:Control
@export var times_up:Control
@export var countdown:Control


func _ready() -> void:
	EventBus.obstacle_placement_timeout.connect(_on_obstacle_placement_timeout)


func initialize() -> void:
	timer.visible = true
	times_up.visible = false
	countdown.visible = true


func _on_obstacle_placement_timeout() -> void:
	times_up.visible = true
