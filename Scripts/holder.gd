extends Node2D

@onready var map=preload("res://Scenes/minimap.tscn")
var mm

func _ready():
	
	set_mm()

func  set_mm():
	mm=map.instantiate()
	$Camera2D.add_child(mm)
