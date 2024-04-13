extends Sprite2D

func take_damage(d):
	$HPBar.take_damage(d)
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Targets")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
