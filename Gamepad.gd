extends Control

func _ready():
	$CenterContainer/VBoxContainer/BackButton.grab_focus()

func _on_BackButton_pressed():
	get_tree().change_scene("res://Steuerung.tscn")
