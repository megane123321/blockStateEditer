class_name ModelDataBase

static var blockModelData:Dictionary

static func getModel(path:String,workPath:String,pathes:Array=[],blockRotateX:float=0,blockRotateY:float=0)->BlockModel:
	var modelKey:String="path={path},x={x},y={y}".format({"path":path,"x":blockRotateX,"y":blockRotateY})
	if blockModelData.has(modelKey):#モデルが既に読み込まれていた場合
		return blockModelData[modelKey]
	else:
		blockModelData[modelKey]=BlockModel.new(path,workPath,pathes,blockRotateX,blockRotateY)
	return blockModelData[modelKey]
