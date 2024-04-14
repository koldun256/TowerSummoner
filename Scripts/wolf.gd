extends Sprite2D

var target = null
@export var attack_range = 30.0
@export var damage = 30
@export var attack_interval = 0.8
var attack_cd = 0
@export var speed = 100
var tower

@onready var anim = get_node("AnimatedSprite2D")

func _ready():
	tower = get_tree().get_first_node_in_group('Shop')
	get_tree().get_first_node_in_group('Player').connect('on_tp', on_tp)
	anim.play("Idle")

func take_damage(d):
	$HPBar.take_damage(d)
	anim.play("GetDamage")

func on_tp(unit, to_tower):
	if unit == self:
		tower = to_tower
	target = choose_target()

func choose_target():
	var nearest_distance = 99999
	var nearest_enemy: Node2D = null

	for enemy in get_tree().get_nodes_in_group("Enemy"): # bipki
		if "Building" in enemy.target2attack.get_groups() and enemy.target2attack != tower:
			continue
		if "Summon" in enemy.target2attack.get_groups() and enemy.target2attack.tower != tower:
			continue
			
		var distance = global_position.distance_to(enemy.global_position)
		if distance < nearest_distance:
			nearest_distance = distance
			nearest_enemy = enemy
	return nearest_enemy

func attack(target):
	target.take_damage(damage)
	anim.play("Attack")

func _process(delta):
	if target == null or not target.is_node_ready():
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
		
	var direction = (target.global_position - position).normalized()
	if direction.x>0:
		anim.flip_h=true
	else:
		anim.flip_h=false
	position += direction * speed * delta
	anim.play("Move")
	
func die():
	queue_free()
