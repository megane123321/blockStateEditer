class_name BlockState

var variants:Array
var multipart:Array
var keyList:Array

func addStateKey(key:String) -> void:
	if not key in keyList:
		keyList.append(key)

func _init(path:String,workPath:String,useWorkPath=true,keys:Array=[]) -> void:
	keyList=keys
	var filePath:String
	if useWorkPath:
		filePath=GameFilePath.getBlockStatePath(path,workPath)
	else:
		filePath=path
	var file=FileAccess.open(filePath,FileAccess.READ)
	if file==null:
		push_error("fileを正しく読み込めませんでした。")
		return
	var json:Dictionary=JSON.parse_string(file.get_as_text())
	if Constant.VARIANT_KEY in json:
		var states:Array=json[Constant.VARIANT_KEY].keys()
		for tmp:String in states:
			var tmpDict:Dictionary
			if tmp=="":
				tmpDict={"":""}
				addStateKey("")
			else:
				var para:Array=tmp.split(",")
				for tmp2:String in para:
					var paras:Array=tmp2.split("=")
					tmpDict[paras[0]]=paras[1]
					addStateKey(paras[0])
			var tmpModel=json[Constant.VARIANT_KEY][tmp]
			var tmpDict2={Constant.VARIANT_KEY:tmpDict}
			if tmpModel is Array:
				var modelArray:Array
				for tmpModel2:Dictionary in tmpModel:
					modelArray.append(modelInBlockState.new(tmpModel2,workPath))
				tmpDict2[Constant.MODEL_KEY]=modelArray
			else:
				tmpDict2[Constant.MODEL_KEY]=modelInBlockState.new(tmpModel,workPath)
			variants.append(tmpDict2)
		#print(KeyList)
	if Constant.MULTI_PART_KEY in json:
		var list:Array=json[Constant.MULTI_PART_KEY]
		for tmp:Dictionary in list:
			var tmpDict:Dictionary
			var tmpModel=tmp["apply"]
			if tmpModel is Array:
				var modelArray:Array
				for tmpModel2:Dictionary in tmpModel:
					modelArray.append(modelInBlockState.new(tmpModel2,workPath))
				tmpDict[Constant.MODEL_KEY]=modelArray
			else:
				tmpDict[Constant.MODEL_KEY]=modelInBlockState.new(tmpModel,workPath)
			if Constant.MULTI_PART_CONDITION in tmp:
				tmpDict[Constant.MULTI_PART_CONDITION]=tmp[Constant.MULTI_PART_CONDITION]
			multipart.append(tmpDict)
	getModelFile({})

func getModelFile(blockState:Dictionary) -> Variant:
	for tmp:Dictionary in variants:
		var keys:Array=blockState.keys()
		var flag:bool=true
		for key in keys:
			if tmp[Constant.VARIANT_KEY][key]!=blockState[key]:
				flag=false;
				break;
		if flag:
			return tmp[Constant.MODEL_KEY]
	for tmp:Dictionary in multipart:
		var models:Array
		if whenIs(tmp[Constant.MULTI_PART_CONDITION],blockState):
			models.append(tmp[Constant.MULTI_PART_CONDITION])
		return models
	return

func whenIs(modelState:Dictionary,blockState:Dictionary) -> bool:
	var keys=modelState.keys()
	var returnFlag=true
	for key in keys:
		if modelState[key] is Array:
			if key=="OR":
				var orList=modelState[key]
				var flag:bool=false
				for orWhen in orList:
					flag=whenIs(orWhen,blockState)
					if flag:
						break
				returnFlag=flag
			if key=="AND":
				var andList=modelState[key]
				var flag:bool=true
				for andWhen in andList:
					flag=whenIs(andWhen,blockState)
					if !flag:
						break
				returnFlag=flag
		if modelState[key] is String:
			modelState[key].begins_with()
			pass
	return returnFlag
