class_name MainMenu
extends Control

@export var start_button:Button


func _ready() -> void:
	start_button.grab_focus()


func _on_visibility_changed():
	if visible:
		start_button.grab_focus()
