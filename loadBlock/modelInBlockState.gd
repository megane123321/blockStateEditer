class_name modelInBlockState
extends Node

var models:Array

func add(model:Dictionary,workSpacePath:String)->void:
	models.append(ModelInfo.new(model,workSpacePath))

func _to_string() -> String:
	var returnStr:String="[ "
	for tmp in models:
		if returnStr.length()!=2:
			returnStr+=" , "
		returnStr+=tmp.modelPath
	returnStr+=" ]"
	return returnStr

func getModel(randSeed:int=0) -> BlockModel:
	var random=RandomNumberGenerator.new()
	var allWeight:int=0
	for tmp:ModelInfo in models:
		allWeight+=tmp.weight
	random.seed=randSeed
	return models[random.randi_range(0,allWeight-1)].get_model()

class ModelInfo:
	var modelPath:String=""
	var x:int=0
	var y:int=0
	var uvlock:bool=false
	var weight:int=1
	var workPath:String

	func _init(model:Dictionary,workSpacePath:String) -> void:
		workPath=workSpacePath
		if "model" in model:
			modelPath=model["model"]
		if "x" in model:
			x=model["x"]
		if "y" in model:
			y=model["y"]
		if "uvlock" in model:
			uvlock=model["uvlock"]
		if "weight" in model:
			weight=model["weight"]
		get_model()

	func _to_string() -> String:
		return "model={model}, x={x}, y={y}, uvlock={uvlock}, weight={weight}".format({"model":modelPath,"x":x,"y":y,"uvlock":uvlock,"weight":weight})

	func get_model() -> BlockModel:
		return ModelDataBase.getModel(modelPath,workPath)
