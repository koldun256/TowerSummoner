extends Node2D

var enemies=[
	preload("res://Scenes/skull.tscn"),
	preload("res://Scenes/Cat.tscn"),
	preload("res://Scenes/Josuke.tscn")
]

# Периодичность спавна в секундах
@export var spawn_interval: float = 2.0
@export var wave_interval = 20

var wave
@export var enemies_in_wave=10
@export var wave_plus=2
var need_to_spawn
var spawned_on_this_wave

func _ready():
	wave=0
	spawned_on_this_wave=0
	need_to_spawn=enemies_in_wave
	# Запускаем таймер
	$Timer.start(spawn_interval)

func _on_timer_timeout():
	if(spawned_on_this_wave<need_to_spawn):
		#for i in range(0, wave+1):
		var range=wave
		if wave>2: range=2
		var random_number=0
		if wave!=0: random_number = randi_range(0, range)
		# Создаем новую ноду на основе префаба
		var new_enemy = enemies[random_number].instantiate()
		# Добавляем созданную ноду на сцену
		add_child(new_enemy)
		# Перезапускаем таймер для следующего спавна
		$Timer.start(spawn_interval)
		spawned_on_this_wave+=1
	else:
		wave+=1
		spawned_on_this_wave=0
		need_to_spawn=enemies_in_wave+wave_plus*wave
		$Timer.start(wave_interval)
