extends CharacterBody2D

@export var SPEED : float = 300.0


var target2attack

var randomnum

var point2move

enum {
	SURROUND,
	ATTACK,
	HIT,
}

var state = SURROUND

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	randomnum = rng.randf()
	#point2move = get_circle_position(randomnum)
	target2attack=get_closest_target()

func _physics_process(delta):
	match state:
		SURROUND:
			move(get_circle_position(randomnum), delta)

func move(target, delta):
	var direction = (target - global_position).normalized()
	var desired_velocity = direction*SPEED
	var steering = (desired_velocity - velocity)*delta*2.5
	velocity+=steering
	move_and_slide()
	
func get_circle_position(random):
	var kill_circle_centre = target2attack.global_position
	var radius = 40
	var angle = random*PI*2;
	var x=kill_circle_centre.x+cos(angle)*radius;
	var y=kill_circle_centre.y+sin(angle)*radius;
	
	return Vector2(x, y)

func get_closest_target():
	var nearest_distance = 99999
	var nearest_node: Node2D = null

	# Итерируемся по всем нодам на сцене
	for node in get_tree().get_nodes_in_group("Targets"):
		if node is Node2D:
			var distance = global_position.distance_to(node.global_position)
			if distance < nearest_distance:
				nearest_distance = distance
				nearest_node = node

	return nearest_node
	
