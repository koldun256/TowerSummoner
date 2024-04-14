extends Sprite2D

@export var expire_time = 10
@onready var time_left = expire_time

func _ready():
	pass # Replace with function body.

func _process(delta):
	time_left -= delta
	if time_left <= 0:
		queue_free()
