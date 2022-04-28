extends Area2D

const SPEED = 150
var velocity = Vector2()
var direction = 1
var fhealth = 2

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
	if "Player" in body.name:
		global.setPhealth(global.getPhealth() - 1)
		if global.getPhealth() < 0:
			body.dead()
		global.activatePtimeout()
		connect("reloadlabel", get_parent(), "reloadLabel")
		emit_signal("reloadlabel")
		disconnect("reloadlabel", get_parent(), "reloadLabel")
	if !"Boss" in body.name:
		queue_free()

func _on_Fireball_area_entered(area):
	if "Fireball" in area.name:
		fhealth = fhealth - 1
		if fhealth <= 0:
			queue_free()
