extends Node

var healthtext = "Gesundheit: " + str(global.getPhealth())
var bosshealthtext = "Boss Gesundheit: " + str(global.getBosshealth())
onready var healthlabel = get_node("CanvasLayer/MarginContainer/HBoxContainer/VBoxContainer/Stat03")
onready var bosshealthlabel = get_node("CanvasLayer/MarginContainer/HBoxContainer/VBoxContainer/Stat04")

func _ready():
	global.Bossalive()
	global.calcPhealth()
	global.setScene(get_tree().current_scene.name)
	healthtext = "Gesundheit: " + str(global.getPhealth())
	healthtext.empty()
	healthlabel.text = healthtext
	bosshealthtext = "Boss Gesundheit: " + str(global.getBosshealth())
	bosshealthtext.empty()
	bosshealthlabel.text = bosshealthtext

func reloadLabel():
	healthtext = "Gesundheit: " + str(global.getPhealth())
	healthtext.empty()
	healthlabel.text = healthtext
	bosshealthtext = "Boss Gesundheit: " + str(global.getBosshealth())
	bosshealthtext.empty()
	bosshealthlabel.text = bosshealthtext
	if global.getPhealth() < 0:
		healthtext = "Gesundheit: 0"
		healthtext.empty()
		healthlabel.text = healthtext

func _on_Coin_coin_collected():
	global.setScore(global.getScore() + 2)
