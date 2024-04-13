extends Sprite2D

signal set_target(target: Vector2)

func get_global_rect():
	return Rect2(to_global(get_rect().position), to_global(get_rect().size))

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		print("handling map")

func _on_area_2d_input_event(viewport, event, shape_idx):
	pass
	#if event is InputEventMouseButton and event.pressed:
		## viewport.set_input_as_handled()
		#print("processing map input")
		#set_target.emit(get_global_mouse_position())
