extends Node2D

@export var enemy_node: PackedScene

# Периодичность спавна в секундах
@export var spawn_interval: float = 2.0

func _ready():
	# Запускаем таймер
	$Timer.start(spawn_interval)

# Функция вызывается при срабатывании таймера
func _on_Timer_timeout():
	# Создаем новую ноду на основе префаба
	var new_enemy = enemy_node.instance()

	# Добавляем созданную ноду на сцену
	add_child(new_enemy)

	# Перезапускаем таймер для следующего спавна
	$Timer.start(spawn_interval)
