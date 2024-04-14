extends Sprite2D

signal set_target(target: Vector2)

func get_global_rect():
	return Rect2(to_global(get_rect().position), to_global(get_rect().size))
