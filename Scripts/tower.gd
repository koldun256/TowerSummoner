extends Sprite2D

@export var isHeal=false
@export var isBee=false
var bee:= preload("res://Scenes/Beeeee.tscn")
@export var heal_amount = 20
var canHeal=false

func take_damage(d):
	$HPBar.take_damage(d)

func die():
	queue_free()

func gen_summon_pos():
	return $SummonAura.gen_summon_pos()

func heal(summon):
	if(canHeal):
		print("Heal")
		summon.hill(heal_amount)
		canHeal=false


func _on_timer_timeout():
	if isHeal:
		canHeal=true
	if isBee:
		var newbee=bee.instantiate()
		add_child(newbee)
		newbee.global_position=gen_summon_pos()
		
