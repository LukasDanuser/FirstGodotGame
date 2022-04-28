extends Control

func _ready():
	$CenterContainer/VBoxContainer/Mitwirkende.grab_focus()

func _physics_process(delta):
	if $CenterContainer/VBoxContainer/Mitwirkende.is_hovered() == true:
		$CenterContainer/VBoxContainer/Mitwirkende.grab_focus()
	
	if $CenterContainer/VBoxContainer/BackButton.is_hovered() == true:
		$CenterContainer/VBoxContainer/BackButton.grab_focus()

func _on_Mitwirkende_pressed():
	get_tree().change_scene("res://Mitwirkende.tscn")

func _on_BackButton_pressed():
	get_tree().change_scene("res://TitleScreen.tscn")
