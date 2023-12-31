class_name UI
extends Control

signal game_start_pressed()

@export var main_menu:MainMenu
@export var how_to_play:HowToPlay
@export var obstacle_ui:ObstacleUI
@export var navigation_ui:NavigationUI

var _state_machine: AnimationNodeStateMachinePlayback


func _ready() -> void:
	_state_machine = $MaskAnimationTree["parameters/playback"]
	initialize_ui()


func initialize_ui() -> void:
	main_menu.visible = true
	how_to_play.visible = false
	obstacle_ui.visible = false
	navigation_ui.visible = false


func show_main_menu() -> void:
	main_menu.visible = true


func hide_main_menu() -> void:
	main_menu.visible = false


func mask_hide() -> void:
	_state_machine.travel("MaskHide")


func mask_show() -> void:
	_state_machine.travel("MaskShow")


func show_obst_ui() -> void:
	obstacle_ui.visible = true


func hide_obst_ui() -> void:
	obstacle_ui.visible = false


func show_nav_ui() -> void:
	navigation_ui.visible = true


func hide_nav_ui() -> void:
	navigation_ui.visible = false


func _on_obst_placement_timeout() -> void:
	$ObstTimesUp.visible = true
	var timer = get_tree().create_timer(3)
	timer.timeout.connect(mask_show)
	EventBus.ui_mask_shown.connect(_on_timesup_mask_shown, CONNECT_ONE_SHOT)


func _on_timesup_mask_shown() -> void:
	$ObstTimesUp.visible = false


func _on_start_pressed():
	game_start_pressed.emit()


func _on_how_to_play_pressed():
	$MainMenu.visible = false
	$HowToPlay.visible = true


func _on_quit_pressed():
	get_tree().quit()


func _on_howtoplay_back_pressed():
	$MainMenu.visible = true
	$HowToPlay.visible = false
