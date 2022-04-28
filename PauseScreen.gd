extends Control

func _ready():
	
	$MarginContainer/CenterContainer/VBoxContainer/Resume.grab_focus()

func _physics_process(delta):
	if $MarginContainer/CenterContainer/VBoxContainer/Resume.is_hovered() == true:
		$MarginContainer/CenterContainer/VBoxContainer/Resume.grab_focus()
	if $MarginContainer/CenterContainer/VBoxContainer/MainMenu.is_hovered() == true:
		$MarginContainer/CenterContainer/VBoxContainer/MainMenu.grab_focus()
	if Input.is_action_pressed("ui_up"):
		$MarginContainer/CenterContainer/VBoxContainer/Resume.grab_focus()
	if Input.is_action_pressed("ui_down"):
		$MarginContainer/CenterContainer/VBoxContainer/MainMenu.grab_focus()

func _input(event):
	if event.is_action_pressed("ui_esc"):
		get_tree().paused = not get_tree().paused
		$MarginContainer/CenterContainer/VBoxContainer/Resume.grab_focus()
		visible = not visible
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$Timer.start()
		

func _on_Resume_pressed():
	global.pause = false
	global.timer_pause()
	get_tree().paused = not get_tree().paused
	visible = not visible
	$Timer.start()

func _on_MainMenu_pressed():
	get_tree().paused = not get_tree().paused
	get_tree().change_scene("res://TitleScreen.tscn")

func _on_Timer_timeout():
	if get_tree().paused == true:
		global2.saveTime()
	if get_tree().paused == false:
		global2.saveDif()
		global2.calcDif()
