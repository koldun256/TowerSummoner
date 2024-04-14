extends Camera2D

@export var speed = 500.0
@export var v_margin = 50
@export var h_margin = 50
signal on_click(target: Node2D, click_pos: Vector2)
var bounds

func _ready():
	var map_rect = get_node("../Map").get_global_rect()
	var viewport_size = get_viewport().size
	bounds = Rect2(Vector2(map_rect.position) + Vector2(viewport_size / zoom.x / 2), Vector2(map_rect.size) - viewport_size/zoom.x)

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
	
	global_position += delta * speed * dir
	
	global_position.x = clamp(position.x, bounds.position.x, bounds.end.x)
	global_position.y = clamp(position.y, bounds.position.y, bounds.end.y)
