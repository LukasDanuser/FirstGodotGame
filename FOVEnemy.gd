extends Area2D

const FIREBALL = preload("res://Fireball.tscn")

var is_attacking = false

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			if is_attacking == false and get_parent().is_dead == false:
				var fireball = FIREBALL.instance()
				if $Position2Ds.position.x == 67:
					fireball.set_fireball_direction(-1)
				elif $Position2Ds.position.x == -67:
					fireball.set_fireball_direction(1)
				get_parent().get_parent().get_parent().add_child(fireball)
				fireball.position = $Position2Ds.global_position
				global.saveSlc2()
				global.setSlc2(global.getSaveluckcoin())
				is_attacking = true
				$Timer2.start()

func _on_Timer2_timeout():
	is_attacking = false

func _on_Area2D_area_entered(area):
	if "Fireball" in area.name:
		if is_attacking == false and get_parent().is_dead == false:
			var fireball = FIREBALL.instance()
			if $Position2Ds.position.x == 67:
				fireball.set_fireball_direction(-1)
			elif $Position2Ds.position.x == -67:
				fireball.set_fireball_direction(1)
			get_parent().get_parent().get_parent().add_child(fireball)
			fireball.position = $Position2Ds.global_position
			is_attacking = true
			$Timer2.start()
