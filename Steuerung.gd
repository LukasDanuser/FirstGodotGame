extends Control

func _ready():
	$CenterContainer/VBoxContainer/Keyboard.grab_focus()

func _physics_process(delta):
	if $CenterContainer/VBoxContainer/Keyboard.is_hovered() == true:
		$CenterContainer/VBoxContainer/Keyboard.grab_focus()
	
	if $CenterContainer/VBoxContainer/Gamepad.is_hovered() == true:
		$CenterContainer/VBoxContainer/Gamepad.grab_focus()
	
	if $CenterContainer/VBoxContainer/BackButton.is_hovered() == true:
		$CenterContainer/VBoxContainer/BackButton.grab_focus()
	
	if Input.is_action_pressed("ui_up"):
		$CenterContainer/VBoxContainer/Keyboard.grab_focus()

func _on_Keyboard_pressed():
	get_tree().change_scene("res://Keyboard.tscn")
func _on_BackButton_pressed():
	get_tree().change_scene("res://TitleScreen.tscn")
func _on_Gamepad_pressed():
	get_tree().change_scene("res://Gamepad.tscn")
