extends Area2D

@export var summon_r = 300
@export var hill_amount=20

func gen_summon_pos():
	var angle = randf() * 2 * PI
	return global_position + Vector2.UP.rotated(angle) * summon_r
	

func _on_body_entered(body):
	print("Я пришел")
	if body.is_in_group("Player"):
		body.close_tower = get_parent()
		


func _on_body_exited(body):
	if body.is_in_group("Player"):
		body.close_tower = null
