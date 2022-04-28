extends Control

var file = File.new()

func _ready():
	file.open("res://scores.cfg", file.READ)
	var time = OS.get_datetime()
	var year = time["year"]
	var month = time["month"]
	var day = time["day"]
	var minute = time["minute"]
	var hour = time["hour"]
	global.pause = true
	global.timer_pause()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$CenterContainer/VBoxContainer/Title.text = "Glückwunsch! Du hast jede Welt gemeistert und " + str(global.getScore()) + " Münzen gesammelt!"
	$CenterContainer/VBoxContainer/Label2.text = "Du hast dafür " + str(global.mins) + " Minuten und " + str(global.secs) + " Sekunden gebraucht!"
	$CenterContainer/VBoxContainer/Label3.text = "Der Preis deiner Deadcoins ist bei " + str(global.getDeadcoinprice()) + "!"
	$CenterContainer/VBoxContainer/ReplayGameButton.grab_focus()
	highscore.savescores(str(file.get_as_text()) + "\n" + str(day) + "." + str(month) + "." + str(year) + " " + str(hour) + ":" + str(minute) + " Spielzeit: " +  str(global.game_time))

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_vong"):
		OS.shell_open("scores.cfg")
		
	if $CenterContainer/VBoxContainer/ReplayGameButton.is_hovered() == true:
		$CenterContainer/VBoxContainer/ReplayGameButton.grab_focus()
	
	if $CenterContainer/VBoxContainer/MainMenuButton.is_hovered() == true:
		$CenterContainer/VBoxContainer/MainMenuButton.grab_focus()
	
	if Input.is_action_pressed("ui_up"):
		$CenterContainer/VBoxContainer/ReplayGameButton.grab_focus()

func _on_ReplayGameButton_pressed():
	get_tree().change_scene("res://World1.tscn")

func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://TitleScreen.tscn")

func _on_QuitGameButton_pressed():
	get_tree().quit()
