class_name BlockState

var variants:Array#ブロック状態(完全一致)
var multipart:Array#ブロック状態(複数選択可)
var keyList:Array#使用されるキー(ゲーム版ではブロックのソースから取得)

func addStateKey(key:String) -> void:
	if not key in keyList:
		keyList.append(key)

func _init(path:String,workPath:String,useWorkPath=true,keys:Array=[]) -> void:
	keyList=keys#外部からのキー登録
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
	#読み込んだjsonの解析
	if Constant.VARIANT_KEY in json:#完全一致型
		var states:Array=json[Constant.VARIANT_KEY].keys()
		for tmp:String in states:
			var tmpDict:Dictionary
			#ブロック状態キーの登録(ここから)/ゲーム版ではaddStateKey関数削除
			if tmp=="":
				tmpDict={"":""}
				addStateKey("")
			else:
				var para:Array=tmp.split(",")
				for tmp2:String in para:
					var paras:Array=tmp2.split("=")
					tmpDict[paras[0]]=paras[1]
					addStateKey(paras[0])
			#ブロック状態キーの登録(ここまで)
			#モデルファイルとキーの対応付け
			var tmpModel=json[Constant.VARIANT_KEY][tmp]
			var tmpDict2={Constant.VARIANT_KEY:tmpDict}
			var models:modelInBlockState=modelInBlockState.new()
			if tmpModel is Array:
				for tmpModel2:Dictionary in tmpModel:
					models.add(tmpModel2,workPath)#モデルの読み込み
			else:
				models.add(tmpModel,workPath)
			tmpDict2[Constant.MODEL_KEY]=models
			variants.append(tmpDict2)
	#複数選択可型
	if Constant.MULTI_PART_KEY in json:
		var list:Array=json[Constant.MULTI_PART_KEY]
		#モデルとキーの対応付け
		for tmp:Dictionary in list:
			var tmpDict:Dictionary
			var tmpModel=tmp["apply"]
			var models:modelInBlockState=modelInBlockState.new()
			if tmpModel is Array:
				for tmpModel2:Dictionary in tmpModel:
					models.add(tmpModel2,workPath)
			else:
				models.add(tmpModel,workPath)
			tmpDict[Constant.MODEL_KEY]=models
			if Constant.MULTI_PART_CONDITION in tmp:
				tmpDict[Constant.MULTI_PART_CONDITION]=tmp[Constant.MULTI_PART_CONDITION]
			multipart.append(tmpDict)

func getModelFile(blockState:Dictionary) -> Array:#指定したブロック状態に対応したModelInBlockStateの配列を返す
	#完全一致型
	for tmp:Dictionary in variants:
		var keys:Array=blockState.keys()
		var flag:bool=true
		for key in keys:
			if tmp[Constant.VARIANT_KEY][key]!=blockState[key]:
				flag=false;
				break;
		if flag:
			return [tmp[Constant.MODEL_KEY]]
	var models:Array=[]
	#複数選択可(複数モデルが帰ってくるかも)
	for tmp:Dictionary in multipart:
		if !tmp.has(Constant.MULTI_PART_CONDITION) or whenIs(tmp[Constant.MULTI_PART_CONDITION],blockState):
			models.append(tmp[Constant.MODEL_KEY])
	return models

func whenIs(modelState:Dictionary,blockState:Dictionary) -> bool:#複数選択可型の条件クリアチェック
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
		else:
			var notFlag:bool=modelState[key].begins_with("!")
			var checkStr:String
			if notFlag:
				checkStr=modelState[key].substr(1)
			else:
				checkStr=modelState[key]
			var values:Array=checkStr.split("|")
			var flag:bool=false
			for value in values:
				if !blockState.has(key):
					break
				if value==str(blockState[key]):
					flag=true
			returnFlag=flag
			if notFlag:
				returnFlag=!returnFlag
	return returnFlag
