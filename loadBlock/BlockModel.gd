class_name BlockModel
extends Node

var model:Dictionary

func _init(modelPath:String,workPath:String,_pathes:Array=[]) -> void:
	if modelPath in _pathes:
		return
	var file:FileAccess=FileAccess.open(GameFilePath.getModelPath(modelPath,workPath),FileAccess.READ)
	var json:Dictionary
	if not file==null:
		json=JSON.parse_string(file.get_as_text())
		if json.has(Constant.PARENT):
			_pathes.append(workPath)
			model=ModelDataBase.getModel(json[Constant.PARENT],workPath,_pathes).model
			model=merge(model,json)
		else:
			model=json

func merge(mergeModel:Dictionary,dict:Dictionary) -> Dictionary:
	if dict.has(Constant.TEXTURES_KEYS):
		if not mergeModel.has(Constant.TEXTURES_KEYS):
			mergeModel[Constant.TEXTURES_KEYS]={}
		dict[Constant.TEXTURES_KEYS].merge(mergeModel[Constant.TEXTURES_KEYS])
	mergeModel.merge(dict,true)
	if mergeModel.has(Constant.TEXTURES_KEYS):
		replaceTextureKey(mergeModel,mergeModel[Constant.TEXTURES_KEYS])
	return mergeModel

func replaceTextureKeyOfDictionary(replace:Dictionary,keys:Dictionary):
	var dictKeys:Array=replace.keys()
	for tmp in dictKeys:
		if replace[tmp] is String:
			if replace[tmp].begins_with("#"):
				var tmpKey:String=replace[tmp].substr(1)
				if keys.has(tmpKey):
					replace[tmp]=keys[tmpKey]
		replaceTextureKey(replace[tmp],keys)

func replaceTextureKeyOfArray(replace:Array,keys:Dictionary):
	for tmp in replace:
		replaceTextureKey(tmp,keys)

func replaceTextureKey(replace:Variant,keys:Dictionary):
	if replace is Dictionary:
		replaceTextureKeyOfDictionary(replace,keys)
	if replace is Array:
		replaceTextureKeyOfArray(replace,keys)

func _to_string() -> String:
	return str(model)
