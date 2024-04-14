extends AudioStreamPlayer2D

var audio_files = [
	preload("res://Music/Josuke theme but it's only the good part (audio-extractor.net).mp3"),
	preload("res://Music/Josuke theme but it's only the good part (audio-extractor.net).mp3"),
	preload("res://Music/kto-to_-_The_CSGO_bhop_song_75483937.mp3"),
	preload("res://Music/Toby_Fox_-_Bonetrousle_64962766.mp3")
]
# Called when the node enters the scene tree for the first time.
func _ready():
	 # Выбираем случайный индекс для аудиофайла
	var random_index = randi() % audio_files.size()

	# Устанавливаем случайно выбранный аудиофайл в качестве потока для аудиоплеера
	stream = audio_files[random_index]

	# Воспроизводим выбранную песню
	play()
