class_name NavigationUI
extends Control

@export var timer:Control
@export var finished:Control
@export var finish_label:Label
@export var main_menu_button:Button
@export var final_time_label:Label
@export var game:Game


func initialize() -> void:
	timer.visible = true
	finished.visible = false


func present_victory_results() -> void:
	var minutes = (game.nav_stopwatch as int) / 60
	var seconds = (game.nav_stopwatch as int) % 60
	finish_label.text = "Finished!"
	final_time_label.text = "Final Time: %d:%02d" % [minutes, seconds]
	finished.visible = true
	main_menu_button.grab_focus()


func present_failed_results() -> void:
	finish_label.text = "Failed!"
	final_time_label.text = "Too many obstacles blocked the path!"
	finished.visible = true
	main_menu_button.grab_focus()


func _on_main_menu_pressed():
	EventBus.return_to_main_pressed.emit()
