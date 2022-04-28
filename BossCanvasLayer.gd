extends CanvasLayer

func _physics_process(delta):
	$MarginContainer/HBoxContainer/VBoxContainer/Stat01.text = get_tree().get_current_scene().get_name()
	$MarginContainer/HBoxContainer/VBoxContainer/Stat02.text = global.game_time
