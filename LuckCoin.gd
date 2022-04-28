extends Area2D

signal coin_collected
signal luckcoin_collected
signal luckcoin_use

func _ready():
	$AnimatedSprite.play("default")

func enemy_coin():
	connect("coin_collected", get_parent(), "_on_Coin_coin_collected")

func _on_Coin_body_entered(body):
	if "Player" in body.name:
		if global.getDeadcoins() == 5 and global.getDeadcoinprice() == 5:
			global.setSaveluckcoin(global.getSaveluckcoin() + 1)
			connect("luckcoin_collected", get_parent(), "reloadLabels")
			emit_signal("luckcoin_collected")
			disconnect("luckcoin_collected", get_parent(), "reloadLabels")
		else:
			emit_signal("coin_collected")
			global.setDeadcoins(5)
			global.setDeadcoinprice(5)
			global.setDeadresetamount(0)
			global.setDeaths(5)
			connect("luckcoin_collected", get_parent(), "reloadLabels")
			connect("luckcoin_use", get_parent(), "slc_use")
			emit_signal("luckcoin_collected")
			emit_signal("luckcoin_use")
			disconnect("luckcoin_collected", get_parent(), "reloadLabels")
			disconnect("luckcoin_use", get_parent(), "slc_use")
		queue_free()
