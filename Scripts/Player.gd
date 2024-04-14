extends CharacterBody2D

var target = null
@export var speed = 500.0;
@onready var marker = get_node("../Marker")
@export var tower_interact_range = 100
var close_tower = null
signal on_tp(unit: Node2D, tower: Node2D)
signal on_balance_change(balance: int)
var coins = 0

func set_target(new_target):
	target = new_target
	marker.position = target
	marker.visible = true

func unset_target():
	target = null
	marker.visible = false

func spend(amount):
	coins -= amount
	on_balance_change.emit(coins)
	
func add_coin():
	coins += 1
	on_balance_change.emit(coins)

func select_summon(pos):
	if not close_tower:
		print('not in range')
		return
	var min_distance = INF
	var unit = null
	for group in ['Summon', 'Enemy']:
		for summon in get_tree().get_nodes_in_group(group):
			var dist = pos.distance_to(summon.global_position)
			if dist < min_distance:
				min_distance = dist
				unit = summon
	
	if unit == null:
		return
	
	unit.global_position = close_tower.gen_summon_pos()
	on_tp.emit(unit, close_tower)
	
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_left_click"):
		select_summon(get_global_mouse_position())
	if Input.is_action_just_pressed("ui_right_click"):
		set_target(get_global_mouse_position())
		
	if target == null:
		return
	var direction = (target - position).normalized()
	move_and_collide(direction * speed * delta)
	if (target - position).length() < speed * delta:
		unset_target()
