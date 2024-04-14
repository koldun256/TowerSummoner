extends Node2D

@onready var load_time = Time.get_ticks_msec()
var towers_count = 4
@onready var timer = get_node('CanvasLayer/Timer')
var isPaused=false
@onready var pause_menu = $CanvasLayer/PauseMenu
func save(content):
	var file = FileAccess.open("user://highscore.dat", FileAccess.WRITE)
	file.store_string(content)

func load_highscore():
	if not FileAccess.file_exists("user://highscore.dat"):
		return '0'
	var file = FileAccess.open("user://highscore.dat", FileAccess.READ)
	var content = file.get_as_text()
	return content
	
var highscore
func _ready():
	highscore = int(load_highscore())
	print(highscore)
	var minutes = str(highscore / 60)
	var seconds = str(highscore % 60)
	get_node('CanvasLayer/HighscoreLabel').text = minutes + ':' + seconds


func destroy_tower():
	print('destroy tower')
	towers_count -= 1
	if towers_count == 0:
		highscore = max(highscore, (Time.get_ticks_msec() - load_time) / 1000)
		save(str(highscore))
		get_tree().reload_current_scene()

func _process(delta):
	var seconds = (Time.get_ticks_msec() - load_time) / 1000
	var minutes = seconds / 60
	seconds %= 60
	timer.text = str(minutes) + ':' + str(seconds)
	
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
func pauseMenu():
	if isPaused:
		pause_menu.hide()
		Engine.time_scale=1
	else:
		pause_menu.show()
		Engine.time_scale=0
	isPaused=!isPaused
