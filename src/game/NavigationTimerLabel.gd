extends Label


@export var game:Game


func _process(_delta) -> void:
	var minutes = (game.nav_stopwatch as int) / 60
	var seconds = (game.nav_stopwatch as int) % 60
	text = "%02d:%02d" % [minutes, seconds]
