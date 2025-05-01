class_name ModelDataBase

static var blockModelData:Dictionary

static func getModel(path:String,workPath:String,pathes:Array=[])->BlockModel:
	if blockModelData.has(path):#モデルが既に読み込まれていた場合
		return blockModelData[path]
	else:
		blockModelData[path]=BlockModel.new(path,workPath,pathes)
	return blockModelData[path]
