class_name TextureDataBase

static var textureData:Dictionary

static func getTexture(path:String,workPath:String)->BlockModel:
	if textureData.has(path):
		return textureData[path]
	else:
		textureData[path]=load(GameFilePath.getTexturePath(path,workPath))
	return textureData[path]
