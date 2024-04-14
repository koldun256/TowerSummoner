extends Control
@export var newzoom = 8
func _ready():
	$SubViewportContainer/SubViewport/Node2D/MainCamera.zoom=newzoom
