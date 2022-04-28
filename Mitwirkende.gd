extends Control

func _ready():
	$CenterContainer/VBoxContainer/OPP.grab_focus()

func _physics_process(delta):
	if $CenterContainer/VBoxContainer/OPP.is_hovered() == true:
		$CenterContainer/VBoxContainer/OPP.grab_focus()
	
	if $CenterContainer/VBoxContainer/bevouliincom.is_hovered() == true:
		$CenterContainer/VBoxContainer/bevouliincom.grab_focus()
	
	if $CenterContainer/VBoxContainer/LetargicDev.is_hovered() == true:
		$CenterContainer/VBoxContainer/LetargicDev.grab_focus()
	
	if $CenterContainer/VBoxContainer/ScagHound.is_hovered() == true:
		$CenterContainer/VBoxContainer/ScagHound.grab_focus()
	
	if $CenterContainer/VBoxContainer/BackButton.is_hovered() == true:
		$CenterContainer/VBoxContainer/BackButton.grab_focus()
	
	if $CenterContainer/VBoxContainer/morgan3d.is_hovered() == true:
		$CenterContainer/VBoxContainer/morgan3d.grab_focus()

func _on_OPP_pressed():
	OS.shell_open("http://www.openpixelproject.com/")
func _on_Stacheln_pressed():
	OS.shell_open("http://bevouliin.com")
func _on_Portal_pressed():
	OS.shell_open("https://opengameart.org/users/letargicdev")
func _on_BackButton_pressed():
	get_tree().change_scene("res://TitleScreen.tscn")
func _on_Fireball_pressed():
	OS.shell_open("https://opengameart.org/users/scaghound")
func _on_morgan3d_pressed():
	OS.shell_open("https://opengameart.org/users/morgan3d")
