class_name HowToPlay
extends Control

@export var back_button:Button

func _on_visibility_changed():
	if visible:
		back_button.grab_focus()
