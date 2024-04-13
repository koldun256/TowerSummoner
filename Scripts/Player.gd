extends Sprite2D

var target = null
@export var speed = 500.0;

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		target = get_global_mouse_position()

func _process(delta):
	if target == null:
		return
	var direction = (target - position).normalized()
	position += direction * speed * delta
	
	if (target - position).length() < speed * delta:
		target = null
