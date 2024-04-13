extends Sprite2D

var target = null
@export var speed = 500.0;
@onready var marker = get_node("../Marker")
@export var tower_interact_range = 100
var close_tower = null

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

	close_tower = null
	for tower in get_tree().get_nodes_in_group("Building"):
		if global_position.distance_to(tower.global_position) < tower_interact_range:
			close_tower = tower
