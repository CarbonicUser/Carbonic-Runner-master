extends BaseScene


func _ready():
	await get_tree().create_timer(0.2).timeout
	GameTimer.stop()
	MusicManager.play_music(preload("res://world/sound/fnaf ucn.wav"))
