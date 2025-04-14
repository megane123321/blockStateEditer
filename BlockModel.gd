class_name BlockModel
extends Node

func _init(modelPath:String,workPath:String) -> void:
	print(GameFilePath.getModelPath(modelPath,workPath))
	var file:FileAccess=FileAccess.open(GameFilePath.getModelPath(modelPath,workPath),FileAccess.READ)
	var json:Dictionary
	if not file==null:
		json=JSON.parse_string(file.get_as_text())
		print("not null")
	print(json)
