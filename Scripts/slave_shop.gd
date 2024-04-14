extends Sprite2D
signal open_shop
signal close_shop

func take_damage(d):
	$HPBar.take_damage(d)

func die():
	queue_free()

func gen_summon_pos():
	return $SummonAura.gen_summon_pos()


func _on_summon_aura_body_entered(body):
	if body.is_in_group('Player'):
		open_shop.emit()


func _on_summon_aura_body_exited(body):
	if body.is_in_group('Player'):
		close_shop.emit()
