extends Sprite2D

func take_damage(d):
	$HPBar.take_damage(d)
	
func die():
	print("oh no im dead")
	queue_free()

func _ready():
	add_to_group("Targets")

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		print("asdfasdf")
		body.close_tower = self

func _on_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		body.close_tower = null
