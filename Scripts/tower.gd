extends Sprite2D

func take_damage(d):
	$HPBar.take_damage(d)

func die():
	queue_free()

func gen_summon_pos():
	return $SummonAura.gen_summon_pos()
