extends Camera2D

@export var speed = 500.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var dir_x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var dir_y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	position.x += delta * speed * dir_x
	position.y += delta * speed * dir_y
	pass
