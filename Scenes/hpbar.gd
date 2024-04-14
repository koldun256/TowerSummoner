extends Control

@export var max_health = 100
@export var health = max_health

signal on_change(health)
signal death

func _ready():
	$ProgressBar.max_value = max_health
	$ProgressBar.value = health

func take_damage(d):
	health -= d
	if health <= 0:
		death.emit()
		health = 0
		return
	on_change.emit(health)
	$ProgressBar.value = health
func heal(h):
	health+=h
	$ProgressBar.value = health
