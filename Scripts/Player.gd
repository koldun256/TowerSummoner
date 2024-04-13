extends Sprite2D

var target = null
@export var speed = 500.0;
@onready var marker = get_node("../Marker")

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		target = get_global_mouse_position()
		print(target)
		marker.position = target
		marker.visible = true

func _process(delta):
	if target == null:
		return
	var direction = (target - position).normalized()
	position += direction * speed * delta
	
	if (target - position).length() < speed * delta:
		target = null
		marker.visible = false
