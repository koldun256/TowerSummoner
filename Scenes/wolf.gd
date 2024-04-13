extends Sprite2D

@onready var enemy_spawner = get_node("../EnemySpawner")
var target = null
@export var attack_range = 30.0
@export var damage = 30
@export var attack_interval = 0.8
var attack_cd = 0
@export var speed = 500

func take_damage(d):
	$HPBar.take_damage(d)
	
func choose_target():
	var nearest_distance = 99999
	var nearest_node: Node2D = null

	for node in enemy_spawner.get_children():
		var distance = global_position.distance_to(node.global_position)
		if distance < nearest_distance:
			nearest_distance = distance
			nearest_node = node
	return nearest_node

func attack(target):
	target.take_damage(damage)

func _process(delta):
	if target == null:
		target = choose_target()
		if target == null:
			return
			
	if global_position.distance_to(target.global_position) <= attack_range:
		if attack_cd > 0:
			attack_cd -= delta
			return
		attack(target)
		attack_cd = attack_interval
		return

	var direction = (target.position - position).normalized()
	position += direction * speed * delta
