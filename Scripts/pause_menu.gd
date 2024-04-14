extends Control

@onready var main = $"../../"

func _on_resume_pressed():
	main.pauseMenu()


func _on_restart_pressed():
	Engine.time_scale=1
	 # Загружаем текущую сцену
	var scene = get_tree().get_current_scene()

	# Перезагружаем текущую сцену
	get_tree().reload_current_scene()


func _on_quit_pressed():
	get_tree().quit()
