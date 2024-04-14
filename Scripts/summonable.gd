extends Node

@onready var player = get_tree().get_first_node_in_group("Player")

func summon():
	if player.close_tower != null:
		get_parent().global_position = player.global_position
		player.unset_target()
		
func _on_area_2d_input_event(viewport, event, shape_idx):
	print("enemy input event")
	if event is InputEventMouseButton and event.pressed:
		print("enemy clicked")
		# viewport.set_input_as_handled()
		summon()
