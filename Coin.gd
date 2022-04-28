extends Area2D

signal coin_collected

func _ready():
	$AnimatedSprite.play("default")

func enemy_coin():
	connect("coin_collected", get_parent(), "_on_Coin_coin_collected")

func _on_Coin_body_entered(body):
	if "Player" in body.name:
		emit_signal("coin_collected")
		queue_free()
