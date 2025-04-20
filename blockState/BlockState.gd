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
	if "variants" in json:
		var states:Array=json["variants"].keys()
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
			var tmpModel=json["variants"][tmp]
			var tmpDict2={"variants":tmpDict}
			if tmpModel is Array:
				var modelArray:Array
				for tmpModel2:Dictionary in tmpModel:
					modelArray.append(modelInBlockState.new(tmpModel2,workPath))
				tmpDict2["model"]=modelArray
			else:
				tmpDict2["model"]=modelInBlockState.new(tmpModel,workPath)
			variants.append(tmpDict2)
		#print(KeyList)
	if "multipart" in json:
		var list:Array=json["multipart"]
		for tmp:Dictionary in list:
			var tmpDict:Dictionary
			var tmpModel=tmp["apply"]
			if tmpModel is Array:
				var modelArray:Array
				for tmpModel2:Dictionary in tmpModel:
					modelArray.append(modelInBlockState.new(tmpModel2,workPath))
				tmpDict["model"]=modelArray
			else:
				tmpDict["model"]=modelInBlockState.new(tmpModel,workPath)
			if "when" in tmp:
				tmpDict["when"]=tmp["when"]
			multipart.append(tmpDict)

func getModelFile(blockState:Dictionary) -> Variant:
	for tmp:Dictionary in variants:
		var keys:Array=blockState.keys()
		var flag:bool=true
		for key in keys:
			if tmp["variants"][key]!=blockState[key]:
				flag=false;
				break;
		if flag:
			return tmp["model"]
	for tmp:Dictionary in multipart:
		pass
	return

func whenIs() -> bool:
	return false
