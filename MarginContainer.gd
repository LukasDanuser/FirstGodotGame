extends MarginContainer

func _physics_process(delta):
	$HBoxContainer/VBoxContainer/Stat01.text = "FPS: " + str(Performance.get_monitor(Performance.TIME_FPS))
	$HBoxContainer/VBoxContainer/Stat02.text = "Memory Static: " + str(round(Performance.get_monitor(Performance.MEMORY_STATIC)/1024/1024)) + " MB"
