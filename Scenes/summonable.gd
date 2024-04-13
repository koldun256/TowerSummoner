extends Node

@onready var player = get_tree().get_first_node_in_group("Player")

func summon():
	print("clicked " + get_parent().name)
	if player.close_tower != null:
		print("...and player is close to a tower")
		get_parent().global_position = player.close_tower.global_position

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		summon()
