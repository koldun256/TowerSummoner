extends Sprite2D

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
