extends Control

@onready var psina = preload('res://Scenes/wolf.tscn')
@onready var hamster = preload('res://Scenes/Hamster.tscn')
@onready var capybara = preload('res://Scenes/capybara.tscn')
@onready var player = get_tree().get_first_node_in_group('Player')
@onready var shop = get_tree().get_first_node_in_group('Shop')

@onready var slaves = [hamster, psina, capybara]
@export var portraits: Array[Texture2D] = []
var costs = [4, 6, 8]

func _ready():
	hide_shop()
	for i in range(3):
		var button = get_node('ShopButton'+str(i))
		button.set_cost(costs[i])
		button.set_icon(portraits[i])

func show_shop():
	visible = true
	
func hide_shop():
	visible = false

func buy(slave, cost):
	player.unhandled = false
	if player.coins >= cost:
		player.spend(cost)
		var new_slave = slave.instantiate()
		shop.get_parent().add_child(new_slave)
		new_slave.global_position = shop.gen_summon_pos()

func buy_psina():
	buy(psina, costs[1])
	
func buy_hamster():
	buy(hamster, costs[0])

func buy_capybara():
	buy(capybara, costs[2])
