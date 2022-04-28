extends Control

func _ready():
	global.pause = true
	global.timer_pause()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if global.getScene() == "Boss":
		$CenterContainer/VBoxContainer/Label.text = "Du bist bis zum " + str(global.getScene()) + " gekommen und hast " + str(global.getScore()) + " Münzen gesammelt!"
	else:
		$CenterContainer/VBoxContainer/Label.text = "Du bist bis " + str(global.getScene()) + " gekommen und hast " + str(global.getScore()) + " Münzen gesammelt!"
	$CenterContainer/VBoxContainer/Label2.text = "Du hast dafür " + str(global.mins) + " Minuten und " + str(global.secs) + " Sekunden gebraucht!"
	$CenterContainer/VBoxContainer/Label3.text = "Der Preis deiner Deadcoins ist bei " + str(global.getDeadcoinprice()) + "!"
	$CenterContainer/VBoxContainer/Again.grab_focus()

func _physics_process(delta):
	
	if $CenterContainer/VBoxContainer/Again.is_hovered():
		$CenterContainer/VBoxContainer/Again.grab_focus()
	if $CenterContainer/VBoxContainer/MainMenu.is_hovered():
		$CenterContainer/VBoxContainer/MainMenu.grab_focus()
		if Input.is_action_pressed("ui_up"):
			$CenterContainer/VBoxContainer/Again.grab_focus()

func _on_Again_pressed():
	get_tree().change_scene("res://World1.tscn")

func _on_MainMenu_pressed():
	get_tree().change_scene("res://TitleScreen.tscn")
