extends Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_global_rect():
	return Rect2(to_global(get_rect().position), to_global(get_rect().size))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
