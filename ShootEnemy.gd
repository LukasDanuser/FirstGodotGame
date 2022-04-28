extends KinematicBody2D

const GRAVITY = 20
const FLOOR = Vector2(0, -1)
const COIN = preload("res://Coin.tscn")
const LUCKCOIN = preload("res://LuckCoin.tscn")

var velocity = Vector2()
var direction = -1
var is_dead = false
var coin = COIN.instance()
var coin2 = COIN.instance()
var coin3 = COIN.instance()
var luckcoin = LUCKCOIN.instance()

signal coin_drop

export(int) var speed = 30
export(int) var hp = 1

func dead():
	hp = hp - 1
	if hp <= 0:
		is_dead = true
		velocity = Vector2(0, 0)
		$AnimatedSprite.play("Dead")
		$CollisionShape2D.call_deferred("set_disabled", true)
		$Timer.start()

func _physics_process(delta):
	if is_dead == false:
		velocity.x = speed * direction
		
		if direction == 1:
			$AnimatedSprite.flip_h = true
			$Area2D/Position2Ds.position.x = -67
		
		elif direction == -1:
			$AnimatedSprite.flip_h = false
			$Area2D/Position2Ds.position.x = 67
		
		$AnimatedSprite.play("Walk")
		velocity.y += GRAVITY
		velocity = move_and_slide(velocity, FLOOR)
	
	if is_on_wall():
		direction = direction * -1
		$RayCast2D.position.x *= -1
		$Area2D.position.x *= -1
		
	if $RayCast2D.is_colliding() == false:
		direction = direction * -1
		$RayCast2D.position.x *= -1
		$Area2D.position.x *= -1
		$Area2D/Position2Ds.position.x *= -1
	
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if "Player" in get_slide_collision(i).collider.name:
				if global.getScore() < global.getDeadcoins():
					get_slide_collision(i).collider.dead()
				if global.getSaveluckcoin() <= 0 and global.getDeadComplete() == false:
					global.setDead(global.getDead() + 1)
					global.setDeadComplete(true)
				elif global.getSaveluckcoin() > 0:
					get_slide_collision(i).collider.lucky_death()

func _on_Timer_timeout():
	randomize()
	var luck_coin = randi()%14+1
	randomize()
	var luck_coin2 = randi()%14+1
	randomize()
	var coin_amount = randi()%7+1
	
	if luck_coin == luck_coin2 or luck_coin == luck_coin2 + 1:
		get_parent().get_parent().add_child(luckcoin)
		luckcoin.position = $Position2D4.global_position
		connect("coin_drop", luckcoin, "enemy_coin")
		emit_signal("coin_drop")
		disconnect("coin_drop", luckcoin, "enemy_coin")
	
	if coin_amount == 3:
		get_parent().get_parent().add_child(coin)
		get_parent().get_parent().add_child(coin2)
		get_parent().get_parent().add_child(coin3)
		coin.position = $Position2D.global_position
		coin2.position = $Position2D2.global_position
		coin3.position = $Position2D3.global_position
		connect("coin_drop", coin, "enemy_coin")
		connect("coin_drop", coin2, "enemy_coin")
		connect("coin_drop", coin3, "enemy_coin")
		emit_signal("coin_drop")
		disconnect("coin_drop", coin, "enemy_coin")
		disconnect("coin_drop", coin2, "enemy_coin")
		disconnect("coin_drop", coin3, "enemy_coin")
	
	elif coin_amount == 2 or coin_amount == 4:
		get_parent().get_parent().add_child(coin)
		get_parent().get_parent().add_child(coin2)
		coin.position = $Position2D.global_position
		coin2.position = $Position2D2.global_position
		connect("coin_drop", coin, "enemy_coin")
		connect("coin_drop", coin2, "enemy_coin")
		emit_signal("coin_drop")
		disconnect("coin_drop", coin, "enemy_coin")
		disconnect("coin_drop", coin2, "enemy_coin")
	
	else:
		get_parent().get_parent().add_child(coin)
		coin.position = $Position2D.global_position
		connect("coin_drop", coin, "enemy_coin")
		emit_signal("coin_drop")
		disconnect("coin_drop", coin, "enemy_coin")
	queue_free()
