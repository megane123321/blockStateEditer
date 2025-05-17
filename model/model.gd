class_name Model
extends Node

var cubes:Array

func _init(modelJson:Dictionary,workPath:String,blockRotateX:float=0,blockRotateY:float=0) -> void:
	if Constant.MODEL_CUBES in modelJson:
		for tmp:Dictionary in modelJson[Constant.MODEL_CUBES]:
			cubes.append(Cube.new(tmp,workPath,blockRotateX,blockRotateY))
	pass
