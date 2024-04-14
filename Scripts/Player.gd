extends CharacterBody2D

var target = null
@export var speed = 500.0;
@onready var marker = get_node("../Marker")
@export var tower_interact_range = 100
@export var tp_intreval = 1.0
var tp_cd = 0
var close_tower = null
signal on_tp(unit: Node2D, tower: Node2D)
signal on_balance_change(balance)
var coins = 10
var unhandled = true
@onready var anim = get_node("AnimatedSprite2D")

var send_marker:= preload("res://Scenes/send_marker.tscn")
var get_marker:= preload("res://Scenes/recieve_marker.tscn")

func _ready():
	await get_tree().process_frame
	on_balance_change.emit(coins)

func add_coin():
	coins += 1
	on_balance_change.emit(coins)
	
func spend(amount):
	coins -= amount
	on_balance_change.emit(coins)

func set_target(new_target):
	target = new_target
	marker.position = target
	marker.visible = true

func unset_target():
	target = null
	marker.visible = false

func select_summon(pos):
	if not close_tower or tp_cd > 0:
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
	anim.play("Cast")
	var send_particle = send_marker.instantiate()
	add_child(send_particle)
	send_particle.global_position=unit.global_position
	
	unit.global_position = close_tower.gen_summon_pos()
	if unit.is_in_group('Summon'):
		unit.tower = close_tower
	unit.retarget()
	tp_cd = tp_intreval
	var get_particle=get_marker.instantiate()
	add_child(get_particle)
	get_particle.global_position=unit.global_position
	
	on_tp.emit(unit, close_tower)
	
func _physics_process(delta):
	if tp_cd > 0:
		tp_cd -= delta
	if Input.is_action_just_pressed("ui_left_click"):
		if unhandled:
			select_summon(get_global_mouse_position())
		else:
			unhandled = true
		
	if Input.is_action_just_pressed("ui_right_click"):
		set_target(get_global_mouse_position())
		anim.play("Move")
		
	if target == null:
		return
	var direction = (target - position).normalized()
	if direction.x>0:
		anim.flip_h=true
	else:
		anim.flip_h=false
	move_and_collide(direction * speed * delta)
	if (target - position).length() < speed * delta:
		unset_target()
		anim.play("Idle")




