extends Area2D

signal reloaded

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			global.setScore(global.getScore2())
			connect("reloaded", get_parent().get_parent(), "reloadLabels")
			emit_signal("reloaded")
			disconnect("reloaded", get_parent().get_parent(), "reloadLabels")
			global.scene_changed()
			if global.getScore() <= 0:
				global.setScore(0)
			if global.getScore() > 0:
				global.setSaveluckcoin(global.getSlc())
				global.setScore(global.getScore2() - 1)
				global.scene_changed()
				connect("reloaded", get_parent().get_parent(), "_ready")
				emit_signal("reloaded")
				disconnect("reloaded", get_parent().get_parent(), "_ready")
				get_tree().reload_current_scene()
			else:
				get_tree().change_scene("DeathMenu.tscn")
