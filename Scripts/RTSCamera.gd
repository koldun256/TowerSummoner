extends Camera2D

@export var speed = 500.0
@export var v_margin = 50
@export var h_margin = 50
signal on_click(target: Node2D, click_pos: Vector2)
var bounds

func _input(event):
	if not (event is InputEventMouseButton and event.pressed):
		return
	var click_pos = get_global_mouse_position()
	for node in get_tree().get_nodes_in_group("Summon"):
		if node.find_child("CollisionShape2D").shape.get_rect().has_point(click_pos):
			on_click.emit(node, click_pos)
			return
	on_click.emit(get_node("../Map"), click_pos)

func _ready():
	var map_rect = get_node("../Map").get_global_rect()
	var viewport_size = get_viewport().size
	bounds = Rect2(Vector2(map_rect.position) + Vector2(viewport_size / 2), Vector2i(map_rect.size) - viewport_size)

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
	
	position.x = clamp(position.x, bounds.position.x, bounds.end.x)
	position.y = clamp(position.y, bounds.position.y, bounds.end.y)
