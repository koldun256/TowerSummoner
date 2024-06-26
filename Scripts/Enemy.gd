extends CharacterBody2D

@export var SPEED : float = 300.0
@export var damage : float = 10
@export var attack_delay: float = 0.8
var attack_cd=0
@export var attack_radius : float = 30
@onready var coin = preload("res://Scenes/coin.tscn")

var can_attack=false

var target2attack

var randomnum

var point2move

@onready var anim = get_node("AnimatedSprite2D")
var can_play_next_anim=false

enum {
	SURROUND,
	ATTACK,
}

var state = SURROUND

func take_damage(d):
	print("took " + str(d) + " damage")
	$HPBar.take_damage(d)
	anim.play("GetDamage")
	
func _ready():
	add_to_group("Enemy")
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	randomnum = rng.randf()
	target2attack=get_closest_target()
	
	get_tree().get_first_node_in_group('Player').connect('on_tp', on_tp)

func retarget():
	target2attack = get_closest_target()
	
func on_tp(unit, to_tower):
	retarget()

func die():
	print("oh no im dead")
	var instance = coin.instantiate()
	get_parent().add_child(instance)
	instance.global_position = global_position
	queue_free()

func choose_state():
	if target2attack!=null:
		if global_position.distance_to(target2attack.global_position)<=attack_radius:
			state=ATTACK
			#print("Attack")
		else :
			state = SURROUND
			#print("Surround")
	else :
		target2attack=get_closest_target()

func _physics_process(delta):
	choose_state()
	match state:
		SURROUND:
			move(get_circle_position(randomnum), delta)
		ATTACK:
			attack(target2attack, delta)

func attack(target, delta):
	if can_play_next_anim:
		anim.play("Idle")
	if attack_cd > 0:
		attack_cd -= delta
		return
	anim.play("Attack")
	target.take_damage(damage)
	attack_cd = attack_delay

func move(target, delta):
	anim.play("Move")
	var direction = (target - global_position).normalized()
	var desired_velocity = direction*SPEED
	var steering = (desired_velocity - velocity)*delta*2.5
	velocity+=steering
	if direction.x>0:
		anim.flip_h=true
	else:
		anim.flip_h=false
	move_and_slide()
	
func get_circle_position(random):
	var kill_circle_centre = target2attack.global_position
	var angle = random*PI*2
	var radius=attack_radius-10
	var x=kill_circle_centre.x+cos(angle)*radius
	var y=kill_circle_centre.y+sin(angle)*radius
	
	return Vector2(x, y)

func get_closest_target():
	var nearest_distance = INF
	var nearest_node: Node2D = null
	
	for group in ['Summon', 'Building']:
		for node in get_tree().get_nodes_in_group(group):
			var distance = global_position.distance_to(node.global_position)
			if distance < nearest_distance:
				nearest_distance = distance
				nearest_node = node

	return nearest_node

func _on_animated_sprite_2d_animation_changed():
	can_play_next_anim=false


func _on_animated_sprite_2d_animation_finished():
	can_play_next_anim=true

func _on_area_2d_body_entered(body):
	if body.is_in_group('Projectile'):
		take_damage(body.damage)
		body.destroy()
