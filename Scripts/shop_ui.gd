extends Control

@onready var psina = preload('res://Scenes/wolf.tscn')
@onready var player = get_tree().get_first_node_in_group('Player')
@onready var shop = get_tree().get_first_node_in_group('Shop')

func _ready():
	hide_shop()

func show_shop():
	visible = true
	
func hide_shop():
	visible = false

func buy(slave, cost):
	if player.coins >= cost:
		player.spend(cost)
		var new_slave = slave.instantiate()
		shop.get_parent().add_child(new_slave)
		new_slave.global_position = shop.gen_summon_pos()

func buy_psina():
	buy(psina, 2)
