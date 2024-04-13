extends Node2D

var enemy_node:= preload("res://Scenes/enemy.tscn")

# Периодичность спавна в секундах
@export var spawn_interval: float = 2.0

func _ready():
	# Запускаем таймер
	$Timer.start(spawn_interval)

func _on_timer_timeout():
	# Создаем новую ноду на основе префаба
	var new_enemy = enemy_node.instantiate()

	# Добавляем созданную ноду на сцену
	add_child(new_enemy)

	# Перезапускаем таймер для следующего спавна
	$Timer.start(spawn_interval)
