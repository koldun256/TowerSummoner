extends CharacterBody2D

var target = null
@export var speed = 500.0;
@onready var marker = get_node("../Marker")
@export var tower_interact_range = 100
var close_tower = null

func set_target(new_target):
	target = new_target
	marker.position = target
	marker.visible = true

func unset_target():
	target = null
	marker.visible = false

func select_summon(pos):
	if not close_tower:
		return
	var min_distance = INF
	var unit = null
	for group in ['Summon', 'Enemy']:
		for summon in get_tree().get_nodes_in_group(group):
			var dist = pos.distance_to(summon.global_position)
			if dist < min_distance:
				min_distance = dist
				unit = summon
	
	unit.global_position = close_tower.gen_summon_pos()
	
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
