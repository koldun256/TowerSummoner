extends AnimatedSprite2D

func _ready():
	play("TP")
	$Timer.start()


func _on_timer_timeout():
	queue_free()
