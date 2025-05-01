class_name Model
extends Node

var cubes:Array

func _init(modelJson:Dictionary,workPath:String) -> void:
	if Constant.MODEL_CUBES in modelJson:
		for tmp:Dictionary in modelJson[Constant.MODEL_CUBES]:
			add_child(Cube.new(tmp,workPath))
			#cubes.append(Cube.new(tmp,workPath))
	pass
