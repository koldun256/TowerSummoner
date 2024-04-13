extends SubViewport

@onready var camera = $Camera2D

func _physics_process(delta):
	camera.position=owner.find_child("Player").position
