extends Panel

var max_health: int
var health: int

func update(_health):
	health = _health
	$ProgressBar.value = health

func destroy():
	queue_free()

func bind(portrait, hpbar):
	max_health = hpbar.max_health
	$Portrait.texture = portrait
	hpbar.on_change.connect(update)
	$ProgressBar.max_value = max_health
	var container = get_tree().get_first_node_in_group('HPUI-container')
	get_parent().remove_child(self)
	container.add_child(self)
	update(hpbar.health)
	hpbar.death.connect(destroy)
