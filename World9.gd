extends Node

var scoretext = "Coins: " + str(global.getScore())
var pricetext = "Preis Deadcoins: " + str(global.getDeadcoinprice())
var slctext = "Leben: " + str(global.getSaveluckcoin())

onready var scorelabel = get_node("CanvasLayer3/MarginContainer/HBoxContainer/VBoxContainer/Stat02")
onready var pricelabel = get_node("CanvasLayer3/MarginContainer/HBoxContainer/VBoxContainer/Stat05")
onready var slclabel = get_node("CanvasLayer3/MarginContainer/HBoxContainer/VBoxContainer/Stat06")

func _ready():
	global.setScene(get_tree().current_scene.name)
	pricetext = "Preis Deadcoins: " + str(global.getDeadcoinprice())
	pricetext.empty()
	pricelabel.text = pricetext
	scoretext = "Coins: " + str(global.getScore())
	scoretext.empty()
	scorelabel.text = scoretext
	slctext = "Leben: " + str(global.getSaveluckcoin())
	slctext.empty()
	slclabel.text = slctext
	if global.getScore() == 0:
		scorelabel.text = "Coins: 0"

func slc_use():
	reloadLabels()
	$CanvasLayer4/lc_used.show()
	$Timer.start()

func _on_Coin_coin_collected():
	global.setScore(global.getScore() + 1)
	scoretext = "Coins: " + str(global.getScore())
	scoretext.empty()
	scorelabel.text = scoretext
	slctext = "Leben: " + str(global.getSaveluckcoin())
	slctext.empty()
	slclabel.text = slctext

func reloadLabels():
	pricetext = "Preis Deadcoins: " + str(global.getDeadcoinprice())
	pricetext.empty()
	pricelabel.text = pricetext
	scoretext = "Coins: " + str(global.getScore())
	scoretext.empty()
	scorelabel.text = scoretext
	slctext = "Leben: " + str(global.getSaveluckcoin())
	slctext.empty()
	slclabel.text = slctext

func setScoretext(text):
	scoretext = text

func _on_Timer_timeout():
	$CanvasLayer4/lc_used.hide()
