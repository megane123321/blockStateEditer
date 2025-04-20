class_name GameFilePath

const MODEL_FOLDER="models"
const BLOCK_STATE_FOLDER="blockstates"
const TEXTURE_FOLDER="textures"

static func getModelPath(path:String,workPath:String) -> String:
	return getPath(path,workPath,MODEL_FOLDER)

static func getBlockStatePath(path:String,workPath:String) ->String:
	return getPath(path,workPath,BLOCK_STATE_FOLDER)

static func getTexturePath(path:String,workPath:String):
	getPath(path,workPath,TEXTURE_FOLDER)

static func getPath(path:String,workPath:String,type:String) -> String:
	var tmp=path.split(":")
	if tmp.size()==1:
		tmp.insert(0,Constant.GAME_NAME)
	return "{workPath}/{nameSpace}/{type}/{path}.json".format({"workPath":workPath,"nameSpace":tmp[0],"type":type,"path":tmp[1]})
