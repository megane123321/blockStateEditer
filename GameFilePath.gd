class_name GameFilePath

const MODEL_FOLDER="models"

static func getModelPath(path:String,workPath:String) -> String:
	return getPath(path,workPath,MODEL_FOLDER)

static func getPath(path:String,workPath:String,type:String) -> String:
	var tmp=path.split(":")
	if tmp.size()==1:
		tmp.insert(0,Constant.gameName)
	return "{workPath}/{nameSpace}/{type}/{path}.json".format({"workPath":workPath,"nameSpace":tmp[0],"type":type,"path":tmp[1]})
