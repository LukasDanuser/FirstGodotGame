extends Node

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$MarginContainer/VBoxContainer/VBoxContainer/Start.grab_focus()

func _physics_process(delta):
	if $MarginContainer/VBoxContainer/VBoxContainer/Start.is_hovered() == true:
		$MarginContainer/VBoxContainer/VBoxContainer/Start.grab_focus()
	
	if $MarginContainer/VBoxContainer/VBoxContainer/Infos.is_hovered() == true:
		$MarginContainer/VBoxContainer/VBoxContainer/Infos.grab_focus()
	
	if $MarginContainer/VBoxContainer/VBoxContainer/Steuerung.is_hovered() == true:
		$MarginContainer/VBoxContainer/VBoxContainer/Steuerung.grab_focus()

func _on_Start_pressed():
	get_tree().change_scene("res://World1.tscn")
func _on_Infos_pressed():
	get_tree().change_scene("res://Infos.tscn")
func _on_Steuerung_pressed():
	get_tree().change_scene("res://Steuerung.tscn")
