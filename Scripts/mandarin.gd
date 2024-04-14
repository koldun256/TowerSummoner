extends CharacterBody2D

var direction = null
var damage = null
@export var speed = 700

func _physics_process(delta):
	if direction:
		self.move_and_collide(delta * direction * speed)

func destroy():
	queue_free()

func _on_body_entered(body):
	if body.is_in_group('Enemy'):
		body.take_damage(damage)
		queue_free()
