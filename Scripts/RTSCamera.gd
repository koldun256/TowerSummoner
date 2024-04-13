extends Camera2D

@export var speed = 500.0
@export var v_margin = 50
@export var h_margin = 50

func _process(delta):
	var mouse_position = get_viewport().get_mouse_position()
	
	var dir = Vector2.ZERO
	
	if mouse_position.x <= h_margin:
		dir.x = -1
	if mouse_position.x >= get_viewport().size.x - h_margin:
		dir.x = 1
	if mouse_position.y <= v_margin:
		dir.y = -1
	if mouse_position.y >= get_viewport().size.y - v_margin:
		dir.y = 1
	
	position += delta * speed * dir
