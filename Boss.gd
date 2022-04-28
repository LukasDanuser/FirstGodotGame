extends KinematicBody2D

const GRAVITY = 20
const FLOOR = Vector2(0, -1)
const COIN = preload("res://Coin.tscn")

var velocity = Vector2()
var direction = -1
var is_dead = false
var hitsatplayer = 0

signal coin_drop
signal reloadlabel

export(int) var speed = 30

func setDirection(i):
	direction = i

func getDirection():
	return direction

func bossdead():
	global.setBosshealth(global.getBosshealth() - 1)
	connect("reloadlabel", get_parent(), "reloadLabel")
	emit_signal("reloadlabel")
	disconnect("reloadlabel", get_parent(), "reloadLabel")
	if global.getBosshealth() < 0:
		if global.getBosshealth() < 0:
			global.setBosshealth(0)
		connect("reloadlabel", get_parent(), "reloadLabel")
		emit_signal("reloadlabel")
		disconnect("reloadlabel", get_parent(), "reloadLabel")
		is_dead = true
		velocity = Vector2(0, 0)
		$AnimatedSprite.play("Dead")
		$CollisionShape2D.call_deferred("set_disabled", true)
		global.Bossdead()
		$Timer.start()

func _physics_process(delta):
	if is_dead == false:
		velocity.x = speed * direction
		
		if direction == 1:
			$AnimatedSprite.flip_h = true
			$Area2D/Position2Ds.position.x = 32
			$Area2D/CollisionShape2D.position.x = 152
			$Area2D2.position.x = -32
		
		elif direction == -1:
			$AnimatedSprite.flip_h = false
			$Area2D/Position2Ds.position.x = -32
			$Area2D/CollisionShape2D.position.x = -152
			$Area2D2.position.x = 32
		
		$AnimatedSprite.play("Walk")
		velocity.y += GRAVITY
		velocity = move_and_slide(velocity, FLOOR)
	
	if global.getBossleft() == true:
		direction = -1
	
	if global.getBossright() == true:
		direction = 1
	
	if is_on_wall():
		direction = direction * -1
		$RayCast2D.position.x *= -1
		$Area2D.position.x *= -1
		global.setBossleft(false)
		global.setBossright(false)
	
	if $RayCast2D.is_colliding() == false:
		direction = direction * -1
		$RayCast2D.position.x *= -1
		$Area2D.position.x *= -1
		$Area2D/Position2Ds.position.x *= -1
		global.setBossleft(false)
		global.setBossright(false)
	
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if "Player" in get_slide_collision(i).collider.name:
				var savehealth = global.getPhealth()
				if global.getPhealth() >= 0:
					hitsatplayer = hitsatplayer + 1
					global.setPhealth(global.getPhealth() - 1)
				if global.getPhealth() < savehealth - 1:
					global.setPhealth(savehealth - 1)
				if global.getPhealth() < 0:
					get_slide_collision(i).collider.dead()
				connect("reloadlabel", get_parent(), "reloadLabel")
				emit_signal("reloadlabel")
				disconnect("reloadlabel", get_parent(), "reloadLabel")
				if global.getPhealth() >= 0:
					get_parent().get_node("Player").position.x = 32
					get_parent().get_node("Player").position.y = 224

func _on_Timer_timeout():
	var coin = COIN.instance()
	var coin2 = COIN.instance()
	var coin3 = COIN.instance()
	var coin4 = COIN.instance()
	var coin5 = COIN.instance()
	var coin6 = COIN.instance()
	var coin7 = COIN.instance()
	var coin8 = COIN.instance()
	var coin9 = COIN.instance()
	var coin10 = COIN.instance()
	var coin11 = COIN.instance()
	var coin12 = COIN.instance()
	
	get_parent().add_child(coin)
	get_parent().add_child(coin2)
	get_parent().add_child(coin3)
	get_parent().add_child(coin4)
	get_parent().add_child(coin5)
	get_parent().add_child(coin6)
	get_parent().add_child(coin7)
	get_parent().add_child(coin8)
	get_parent().add_child(coin9)
	get_parent().add_child(coin10)
	get_parent().add_child(coin11)
	get_parent().add_child(coin12)
	
	coin.position = $Position2D.global_position
	coin2.position = $Position2D2.global_position
	coin3.position = $Position2D3.global_position
	coin4.position = $Position2D4.global_position
	coin5.position = $Position2D5.global_position
	coin6.position = $Position2D6.global_position
	coin7.position = $Position2D7.global_position
	coin8.position = $Position2D8.global_position
	coin9.position = $Position2D9.global_position
	coin10.position = $Position2D10.global_position
	coin11.position = $Position2D11.global_position
	coin12.position = $Position2D12.global_position
	
	connect("coin_drop", coin, "enemy_coin")
	connect("coin_drop", coin2, "enemy_coin")
	connect("coin_drop", coin3, "enemy_coin")
	connect("coin_drop", coin4, "enemy_coin")
	connect("coin_drop", coin5, "enemy_coin")
	connect("coin_drop", coin6, "enemy_coin")
	connect("coin_drop", coin7, "enemy_coin")
	connect("coin_drop", coin8, "enemy_coin")
	connect("coin_drop", coin9, "enemy_coin")
	connect("coin_drop", coin10, "enemy_coin")
	connect("coin_drop", coin11, "enemy_coin")
	connect("coin_drop", coin12, "enemy_coin")
	emit_signal("coin_drop")
	disconnect("coin_drop", coin, "enemy_coin")
	disconnect("coin_drop", coin2, "enemy_coin")
	disconnect("coin_drop", coin3, "enemy_coin")
	disconnect("coin_drop", coin4, "enemy_coin")
	disconnect("coin_drop", coin5, "enemy_coin")
	disconnect("coin_drop", coin6, "enemy_coin")
	disconnect("coin_drop", coin7, "enemy_coin")
	disconnect("coin_drop", coin8, "enemy_coin")
	disconnect("coin_drop", coin9, "enemy_coin")
	disconnect("coin_drop", coin10, "enemy_coin")
	disconnect("coin_drop", coin11, "enemy_coin")
	disconnect("coin_drop", coin12, "enemy_coin")
	queue_free()
