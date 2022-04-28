extends Node

func savescores(content):
	var file = File.new()
	file.open("res://scores.cfg", file.WRITE)
	file.store_string(content)
	file.close()
