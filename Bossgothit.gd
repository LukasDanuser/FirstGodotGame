extends Area2D

func _on_Area2D2_area_entered(area):
	if area.name == "Fireball":
		if position.x == 32:
			global.setBossleft(false)
			global.setBossright(true)
		elif position.x == -32:
			global.setBossleft(true)
			global.setBossright(false)
