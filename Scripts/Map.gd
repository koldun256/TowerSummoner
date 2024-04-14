extends Sprite2D

signal set_target(target: Vector2)

var coin = preload("res://Scenes/coin.tscn")
@onready var timer = $Timer
func get_global_rect():
	return Rect2(to_global(get_rect().position), to_global(get_rect().size))

func spawn_object_in_random_position(area: Rect2, object_scene):
	# Сгенерировать случайные координаты внутри прямоугольной области
	var random_x = randf_range(area.position.x, area.position.x + area.size.x)
	var random_y = randf_range(area.position.y, area.position.y + area.size.y)

	# Создать объект из сцены
	var new_object = object_scene.instantiate()

	# Установить позицию объекта на случайные координаты
	new_object.position = Vector2(random_x, random_y)

	# Добавить объект на сцену
	get_parent().add_child(new_object)



func _on_timer_timeout():
	spawn_object_in_random_position(get_global_rect(), coin)
