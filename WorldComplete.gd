extends Area2D

export(String, FILE, "*.tscn") var next_world

func _ready():
	$CollisionShape2D.call_deferred("set_disabled", true)

func _physics_process(delta):
	if get_tree().current_scene.name == "Boss":
		if global.getBossdead() == true:
			$CollisionShape2D.call_deferred("set_disabled", false)
		elif global.getBossdead() == false:
			$CollisionShape2D.call_deferred("set_disabled", true)
	if $CollisionShape2D.disabled == true or global.getBossdead() == false:
		$icon.hide()
		$Sprite.show()
	if $CollisionShape2D.disabled == false or global.getBossdead() == true:
		$icon.show()
		$Sprite.hide()
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			global.scene_changed()
			global.slc_save()
			get_tree().change_scene(next_world)

func _on_Coin_coin_collected():
	$CollisionShape2D.call_deferred("set_disabled", false)
