extends Node2D

@onready var load_time = Time.get_ticks_msec()
var towers_count = 4
@onready var timer = get_node('CanvasLayer/Timer')

func destroy_tower():
	print('destroy tower')
	towers_count -= 1
	if towers_count == 0:
		get_tree().reload_current_scene()

func _process(delta):
	var seconds = (Time.get_ticks_msec() - load_time) / 1000
	var minutes = seconds / 60
	seconds %= 60
	timer.text = str(minutes) + ':' + str(seconds)
