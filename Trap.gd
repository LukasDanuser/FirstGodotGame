extends KinematicBody2D

func _physics_process(delta):
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if "Player" in get_slide_collision(i):
				if global.getScore() < global.getDeadcoins():
					get_slide_collision(i).collider.dead()
				else:
					if global.getSaveluckcoin() <= 0:
						var i1 = global.getDeadcoins()
						var i2 = global.getDeadcoinprice()
						global.setScore(global.getScore() - global.getDeadcoins())
						global.setScore2(global.getScore())
						global.setDeaths(global.getDeaths() + 1)
						global.setDeadcoins(global.getDeadcoins() + 1)
						if i1 != global.getDeadcoins() + 1:
							global.setDeadcoins(i1 + 1)
						if i2 != global.getDeadcoinprice() + 1:
							global.setDeadcoinprice(i2 + 1)
						get_tree().reload_current_scene()
					elif global.getSaveluckcoin() > 0:
						get_slide_collision(i).collider.lucky_death()
