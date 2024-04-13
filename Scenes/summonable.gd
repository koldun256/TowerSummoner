extends Node

@onready var player = get_tree().get_nodes_in_group("Player")[0]

func summon():
	print("summoning")
	pass

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		#print("processing unit input")
		summon()
