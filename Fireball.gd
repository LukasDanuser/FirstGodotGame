extends Area2D

const SPEED = 250

var velocity = Vector2()
var direction = 1

signal reloadlabel

func set_fireball_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true
		$CollisionShape2D.position.x = -6

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)
	$AnimatedSprite.play("shoot")

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Fireball_body_entered(body):
	if "Enemy" in body.name:
		if body.name != "Boss":
			body.dead()
	if "Boss" in body.name:
		if global.getBosshealth() < 0:
			global.setBosshealth(0)
		body.bossdead()
		connect("reloadlabel", get_parent(), "reloadLabel")
		emit_signal("reloadlabel")
		disconnect("reloadlabel", get_parent(), "reloadLabel")
	if "Player" in body.name:
		if global.getScore() < global.getDeadcoins():
			body.dead()
		if global.getSaveluckcoin() <= 0 and global.getDeadComplete() == false:
			global.setDead(global.getDead() + 1)
			global.setDeadComplete(true)
		elif global.getSaveluckcoin() > 0:
			body.lucky_death()
	queue_free()

func _on_Fireball_area_entered(area):
	if "Fireball" in area.name:
		queue_free()
