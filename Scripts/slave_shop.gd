extends Sprite2D
signal open_shop
signal close_shop

@export var portrait: Texture2D
@onready var hpui_prefab = preload("res://hpui.tscn")

func _ready():
	var hpui = hpui_prefab.instantiate()
	add_child(hpui)
	hpui.bind(portrait, $HPBar)

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
