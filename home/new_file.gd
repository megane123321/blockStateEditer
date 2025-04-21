class_name NewFile
extends "res://createOverRay.gd"

func _ready() -> void:
	var tmp=RandomNumberGenerator.new()
	tmp.seed=0
	for i in range(0,10):
		print(tmp.randi_range(0,4))
