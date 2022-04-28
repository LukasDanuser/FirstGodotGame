extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCELERATION = 50
const MAX_SPEED = 200
const JUMP_HEIGHT = -550
const FIREBALL = preload("res://Fireball.tscn")

var motion = Vector2()
var cs = 4
var csb = cs + 2
var is_attacking = false
var is_dead = false
var is_attacking_in_boss = false
var timeouttimer = false

signal reloadscoretext
signal slc_used

func _ready():
	global.setDeadComplete(false)

func slc_used():
	connect("slc_used", get_parent(), "slc_use")
	emit_signal("slc_used")
	disconnect("slc_used", get_parent(), "slc_use")

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_veng"):
		get_tree().change_scene("res://EndMenu.tscn")
	if get_tree().current_scene.name == "Boss":
		pass
	if global.getPtimeout() == true and timeouttimer == false:
		$Timer2.start()
		timeouttimer = true
	if is_dead == false:
		motion.y += GRAVITY
		var friction = false
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		if global.getScore() > 0:
			if Input.is_action_just_pressed("ui_reload") and get_tree().current_scene.name != "Boss":
				global.setScore(global.getScore2() - 1)
				global.scene_changed()
				if global.getScore() <= 0:
					global.setScore(0)
				if global.getScore2() <= 0:
					global.setScore2(0)
				global.setSaveluckcoin(global.getSlc())
				get_tree().reload_current_scene()
			else:
				pass
		if global.getSlc2() > global.getSaveluckcoin():
			slc_used()
			global.setSlc2(global.getSlc2() - 1)
			
		if global.getSaveluckcoin() > 0:
			if global.getDeadcoins() > 5 or global.getDeadcoinprice() > 5:
				global.setDeadcoins(5)
				global.setDeadresetamount(0)
				global.setDeaths(5)
				global.setDeadcoinprice(global.getDeadresetamount() + global.getDeaths())
				global.setSaveluckcoin(global.getSaveluckcoin() - 1)
				slc_used()
				connect("reloadscoretext", get_parent(), "reloadLabels")
				emit_signal("reloadscoretext")
				disconnect("reloadscoretext", get_parent(), "reloadLabels")
			else:
				pass
		if global.getDeadcoins() > 5 and global.getScore() >= global.getDeadcoinprice():
			if Input.is_action_just_pressed("ui_resetDeadcoins"):
				global.setScore(global.getScore() - global.getDeadcoinprice())
				global.setDeadresetamount(global.getDeadresetamount() + 1)
				global.scene_changed()
				connect("reloadscoretext", get_parent(), "reloadLabels")
				emit_signal("reloadscoretext")
				disconnect("reloadscoretext", get_parent(), "reloadLabels")
				global.setDeadcoins(5)
		
		if Input.is_action_pressed("ui_right1"):
			if is_attacking == false || is_on_floor() == false:
				motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
				if is_attacking == false:
					$Sprite.flip_h = false
					$Sprite.play("Run")
					if sign($Position2D.position.x) == -1:
						$Position2D.position.x *= -1
		elif Input.is_action_pressed("ui_left1"):
			if is_attacking == false || is_on_floor() == false:
				motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
				if is_attacking == false:
					$Sprite.flip_h = true
					$Sprite.play("Run")
					if sign($Position2D.position.x) == 1:
						$Position2D.position.x *= -1
		else:
			friction = true
			motion.x = lerp(motion.x, 0, 0.3)
			if is_on_floor() == true && is_attacking == false:
				$Sprite.play("Idle")
		
		if Input.is_action_just_pressed("ui_shoot") and is_attacking == false and global.getPtimeout() == false and is_attacking_in_boss == false:
			if is_on_floor():
				motion.x = 0
			if get_tree().current_scene.name == "Boss":
				is_attacking_in_boss = true
				$Timer3.start()
			is_attacking = true
			$Sprite.play("Attack")
			var fireball = FIREBALL.instance()
		
			if sign($Position2D.position.x) == 1:
				fireball.set_fireball_direction(1)
			else:
				fireball.set_fireball_direction(-1)
			get_parent().add_child(fireball)
			fireball.position = $Position2D.global_position
		
		if is_on_floor():
			if motion.y > 0:
				is_attacking = false
			if Input.is_action_pressed("ui_down"):
				$Camera2D.move_local_y(cs)
			if $Camera2D.position.y > motion.y and !Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_cam0"):
				$Camera2D.move_local_y(-csb) == $Sprite.position.y - 6
			if Input.is_action_pressed("ui_up"):
				$Camera2D.move_local_y(-cs)
			if $Camera2D.position.y < motion.y and !Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_cam0"):
				$Camera2D.move_local_y(csb) == $Sprite.position.y - 6
			if Input.is_action_pressed("ui_left"):
				$Camera2D.move_local_x(-cs)
			if $Camera2D.position.x < motion.x and !Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_cam0"):
				$Camera2D.move_local_x(csb) == $Sprite.position.x - 6
			if Input.is_action_pressed("ui_right"):
				$Camera2D.move_local_x(cs)
			if $Camera2D.position.x > motion.x and !Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_cam0"):
				$Camera2D.move_local_x(-csb) == $Sprite.position.x - 6
			if Input.is_action_pressed("ui_cam1"):
				$Camera2D.position = $Sprite.position
			if Input.is_action_just_pressed("ui_jump"):
				if is_attacking == false:
					motion.y = JUMP_HEIGHT
				if friction == true:
					motion.x = lerp(motion.x, 0, 0.3)
		else:
			if is_attacking == false:
				if motion.y < 0:
					$Sprite.play("Jump")
				else:
					$Sprite.play("Fall")
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.05)
		motion = move_and_slide(motion, UP)
		if global.getDead() > 0:
			death()
			get_tree().reload_current_scene()
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Trap" in get_slide_collision(i).collider.name or "Enemy" in get_slide_collision(i).collider.name:
					if get_slide_collision(i).collider.name != "Boss":
						if global.getScore() < global.getDeadcoins():
							dead()
						else:
							if global.getSaveluckcoin() <= 0 and global.getDeadComplete() == false:
								global.setDead(global.getDead() + 1)
								global.setDeadComplete(true)
							if global.getSaveluckcoin() > 0:
								lucky_death()

func lucky_death():
	get_tree().reload_current_scene()
	global.setDeadcoins(global.getDeadcoins() + 1)

func death():
	var i1 = global.getDeadcoins()
	var i2 = global.getDeadcoinprice()
	var dead = global.getDead()
	var price = global.getDeadcoinprice()
	var deadcoin = global.getDeadcoins()
	var deaths = global.getDeaths()
	global.setScore(global.getScore() - global.getDeadcoins())
	global.setScore2(global.getScore())
	global.setDeaths(global.getDeaths() + 1)
	global.setDeadcoins(global.getDeadcoins() + 1)
	global.setDead(global.getDead() + 1)
	if i1 != global.getDeadcoins() + 1:
		global.setDeadcoins(i1 + 1)
	if i2 != global.getDeadcoinprice() + 1:
		global.setDeadcoinprice(i2 + 1)
	if global.getDead() > dead + 1:
		global.setDead(dead + 1)
		global.setDeadcoins(deadcoin + 1)
		global.setDeadcoinprice(price + 1)
		global.setDeaths(deaths + 1)
	global.setDead(0)

func dead():
	is_dead = true
	motion = Vector2(0, 0)
	global.pause = true
	global.timer_pause()
	$Sprite.play("Dead")
	$CollisionShape2D.call_deferred("set_disabled", true)
	$Timer.start()

func _on_Sprite_animation_finished():
	is_attacking = false

func _on_Timer_timeout():
	get_tree().change_scene("res://DeathMenu.tscn")

func _on_Timer2_timeout():
	global.deactivatePtimeout()
	timeouttimer = false

func _on_Timer3_timeout():
	is_attacking_in_boss = false
